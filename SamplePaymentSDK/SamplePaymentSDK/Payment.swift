//
//  Payment.swift
//  SamplePaymentSDK
//
//  Copyright © 2021 Moonsense, Inc. All rights reserved.
//

import UIKit
import MoonsenseSDK

/// The entry point for the SamplePaymentSDK.
public class Payment {

    // MARK: - Public API

    /// Initializes the Sample Payment SDK.
    ///
    /// This method **must** be called first before any other SDK methods.
    public class func initialize() {
        if singleton == nil {
            singleton = Payment(publicToken: moonsensePublicToken)
        }
    }

    /// Captures a payment.
    ///
    /// This method will display the "Swipe to Buy" user interface.
    ///
    /// - Parameters:
    ///   - price: The total price to be charged.
    ///   - completion: A completion block that accepts a boolean value that will be executed when the payment
    ///                 has completed. If the payment was completed `true` will be provided. If the payment was
    ///                 cancelled `false` will be provided.
    public class func capturePayment(price: Double, completion: @escaping (Bool) -> Void) {
        guard let singleton = singleton else {
            NSLog("SamplePaymentSDK is not initialized! Ensure the SamplePaymentSDK is initialized before calling capturePayment.")
            return
        }

        guard let paymentViewController = Payment.storyboard().instantiateViewController(withIdentifier: "paymentViewController") as? PaymentViewController else {
            NSLog("SamplePaymentSDK could not create a PaymentViewController.")
            return
        }

        // Configure PaymentViewController with the necessary information
        paymentViewController.totalPrice = price
        paymentViewController.purchaseCompletion = completion

        singleton.overlayWindow.present(viewController: paymentViewController)
    }

    // MARK: - Internal APIs

    // Your Moonsense public token goes here. This will be compiled into the
    // SamplePaymentSDK, and will not be visible by consumers of this SDK.
    static let moonsensePublicToken = <#YOUR PUBLIC TOKEN#>

    // MARK: - Instance properties
    private let overlayWindow: SDKOverlayWindow

    // MARK: - Singleton
    // This class represents a singleton, therefore we should not be able to create instances outside
    // of the Payment SDK.
    internal static var singleton: Payment?
    private init(publicToken: String) {
        // Creates the SDKOverlayWindow that will be used when displaying the PaymentViewController.
        overlayWindow = SDKOverlayWindow(frame: UIScreen.main.bounds)

        // Disables all MoonsenseSDK Logging
        Moonsense.logLevel = .none

        // Configure SDK:
        // Capture sensors that produce data on intervals at 50Hz.
        // Generate bundles every half second.
        // When no SessionConfig is provided when starting a session, capture these sensors:
        let sdkConfig = SDKConfig(sensorTypes: [.touch, .focusChange, .keyPress, .textChange],
                                  globalSamplingRate: 50,
                                  bundleGenerationInterval: 0.5)
        
        // Initializes the Moonsense SDK
        Moonsense.initialize(publicToken: publicToken, sdkConfig: sdkConfig, delegate: self)
    }

    // MARK: - Resource related helpers
    internal class func frameworkBundle() -> Bundle {
        return Bundle(for: Payment.self)
    }

    internal class func storyboard() -> UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Payment.frameworkBundle())
    }
}

extension Payment: MoonsenseDelegate {
    public func errorDidOccur(error: MoonsenseError) {
        // Log the error that happened and handle it as necessary
    }

    public func didStartSession(_ session: Session) {
        // unused
    }

    public func didStopSession(_ session: Session) {
        // unused
    }
}
