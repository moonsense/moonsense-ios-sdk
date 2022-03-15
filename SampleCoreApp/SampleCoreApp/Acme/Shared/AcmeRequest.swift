//
//  AcmeRequest.swift
//  SampleCoreApp
//
//  Copyright © 2022 Moonsense, Inc. All rights reserved.
//

import Foundation
import MoonsenseCoreSDK

/// Represent the Acme version of the data collected from the Moonsense Bundle.
struct AcmeRequest: Codable {
    /// The id of the `AcmeSession`
    let acmeSessionId: String

    /// The id of the corresponding Moonsense Session
    let moonsenseSessionId: String

    /// For some reason Acme is only interested in Accelerometer data.
    let accelerometerData: [Accelerometer]
}
