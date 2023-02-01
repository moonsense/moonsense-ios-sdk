//
//  AcmeSDK.swift
//  SampleCoreApp
//
//  Copyright © 2022 Moonsense, Inc. All rights reserved.
//

import Foundation
import MoonsenseCoreSDK

/// This SDK is a simple wrapper around the Moonsense Core SDK.
///
/// This SDK demonstrates the use of the Core SDK including the Session state management.
///
/// In this case we associate a Moonsense Session with corresponding Acme Session.
///
/// This example also demonstrates the handling of the Bundle data received via the `MoonsenseDelegate`.
class AcmeSDK {
    private enum Constants {
        static let acmeServerHost = "localhost"
        static let acmeServerPort = 3100
        static let acmeServerDataPath = "/v1/data/"
    }

    private let jsonEncoder = JSONEncoder()
    private let jsonDecoder = JSONDecoder()

    /// Maps a Moonsense Session to an AcmeSession.
    private var sessionMap: [String : AcmeSession] = [:]

    init() {
        // Configure SDK:
        // Generate a bundle every second
        // Only record accelerometer data
        let sdkConfig = SDKConfig(sensorTypes: [.accelerometer],
                                  bundleGenerationInterval: 1.0)

        Moonsense.initialize(sdkConfig: sdkConfig, delegate: self)
    }

    /// Record an `AcmeSession`.
    ///
    /// Internally we also start a Moonsense Session.
    @discardableResult
    func record() -> AcmeSession {
        let acmeSession = AcmeSession(sessionId:UUID().uuidString)
        let moonsenseSession = try! Moonsense.startSession(duration: 10)
        let moonsenseLocalId = moonsenseSession.localID

        print("Moonsense Session created with id \(moonsenseLocalId)")
        sessionMap[moonsenseLocalId] = acmeSession
        return acmeSession
    }

    func uploadData(request: AcmeRequest) {
        var components = URLComponents()
        components.scheme = "http"
        components.host = Constants.acmeServerHost
        components.port = Constants.acmeServerPort
        components.path = Constants.acmeServerDataPath

        let data = try! jsonEncoder.encode(request)

        var urlRequest = URLRequest(url: components.url!)
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = data

        urlSession.dataTask(with: urlRequest) { responseData, URLResponse, error in
            if let responseData = responseData,
               let acmeResponse = try? self.jsonDecoder.decode(AcmeResponse.self, from: responseData) {
                print("Total samples uploaded: \(acmeResponse.count)")
            } else if let error = error {
                print("Error uploading data \(error.localizedDescription)")
            }
        }.resume()
    }

    private var urlSession: URLSession = {
        let config = URLSessionConfiguration.ephemeral
        config.networkServiceType = .responsiveData
        config.shouldUseExtendedBackgroundIdleMode = true
        config.allowsCellularAccess = true
        config.waitsForConnectivity = true
        config.httpAdditionalHeaders = ["Accept" : "application/json",
                                        "Content-Type" : "application/json"]

        return URLSession(configuration: config)
    }()
}

extension AcmeSDK: MoonsenseDelegate {
    func sessionDidCreateBundle(_ session: Session, bundle: MoonsenseBundle) {
        guard let acmeSession = sessionMap[session.localID] else {
            return
        }

        uploadData(request: AcmeRequest(acmeSessionId: acmeSession.sessionId,
                                        moonsenseSessionId: session.localID,
                                        accelerometerData: bundle.accelerometerData))
    }

    func errorDidOccur(error: MoonsenseError) {
        print("Moonsense error reported \(error.localizedDescription)")
    }

    func didStartSession(_ session: Session) {
        // not used, AcmeSession created when record() is called.
    }

    func didStopSession(_ session: Session) {
        let moonsenseLocalId = session.localID
        defer {
            sessionMap.removeValue(forKey: moonsenseLocalId)
        }

        // Remove the AcmeSession entry
        print("Moonsense Session with id \(moonsenseLocalId) stopped.")

        if let acmeSession = sessionMap[moonsenseLocalId] {
            print("Shutting down Acme Session with id \(acmeSession.sessionId)")
        }
    }
}
