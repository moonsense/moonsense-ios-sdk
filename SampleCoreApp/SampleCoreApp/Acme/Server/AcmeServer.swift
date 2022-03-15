//
//  AcmeServer.swift
//  SampleCoreApp
//
//  Copyright © 2022 Moonsense, Inc. All rights reserved.
//

import Foundation
import GCDWebServers

/// Used to notify in case of data received by the server.
protocol AcmeServerDelegate {

    /// Called when data is received on an Acme session. Returns the count of samples
    ///  received along with the acme session id.
    func receivedData(sessionId: String, count: Int)
}

/// Implements a simple local server.
class AcmeServer {
    enum Constants {
        static let serverPort:UInt = 3100
        static let method = "POST"
        static let path = "/v1/data/"
    }

    let webServer = GCDWebServer()

    let delegate: AcmeServerDelegate

    init(delegate: AcmeServerDelegate) {
        self.delegate = delegate

        GCDWebServer.setLogLevel(2)

        webServer.addHandler(forMethod: Constants.method,
                             path: Constants.path,
                             request: GCDWebServerDataRequest.self) { request, completion  in
            let decoder = JSONDecoder()
            guard let request = request as? GCDWebServerDataRequest,
                  request.hasBody(),
                  let acmeRequest = try? decoder.decode(AcmeRequest.self, from: request.data) else {
                      completion(GCDWebServerResponse(statusCode: GCDWebServerClientErrorHTTPStatusCode.httpStatusCode_BadRequest.rawValue))
                    return
            }

            // Process data
            delegate.receivedData(sessionId: acmeRequest.acmeSessionId, count: acmeRequest.accelerometerData.count)

            let acmeResponse = AcmeResponse(count: acmeRequest.accelerometerData.count)

            let encoder = JSONEncoder()
            guard let data = try? encoder.encode(acmeResponse) else {
                completion(GCDWebServerResponse(statusCode: GCDWebServerServerErrorHTTPStatusCode.httpStatusCode_InternalServerError.rawValue))
                return
            }

            completion(GCDWebServerDataResponse(data: data, contentType: "application/json"))
        }

        webServer.start(withPort: Constants.serverPort, bonjourName: "AcmeServer")
    }
}
