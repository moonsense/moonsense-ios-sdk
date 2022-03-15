//
//  AcmeSession.swift
//  SampleCoreApp
//
//  Copyright © 2022 Moonsense, Inc. All rights reserved.
//

/// Representation of an Acme Session.
import Foundation

class AcmeSession{
    /// Unique id for the Session.
    let sessionId: String

    init(sessionId: String) {
        self.sessionId = sessionId
    }
}
