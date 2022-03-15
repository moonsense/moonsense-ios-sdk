//
//  AcmeResponse.swift
//  SampleCoreApp
//
//  Copyright © 2022 Moonsense, Inc. All rights reserved.
//

import Foundation

/// Returns a result of the data upload.
struct AcmeResponse: Codable {
    /// Number of samples processed.
    let count: Int
}
