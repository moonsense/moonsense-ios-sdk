//
//  SDKOverlayWindow.swift
//  SamplePaymentSDK
//
//  Copyright © 2021 Moonsense, Inc. All rights reserved.
//

import UIKit

// The `SDKOverlayWindow` will be used to display all UIComponents from the SamplePaymentSDK.
// This approach ensures that the views owned by the SamplePaymentSDK do not interfere
// with any view hierachies from the app consuming the SamplePaymentSDK framework.
class SDKOverlayWindow: UIWindow {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    private func setup() {
        backgroundColor = UIColor.clear
        isHidden = true
        windowLevel = .statusBar - 1
    }

    // Presents the provided view controller via the the `SDKOverlayWindow.`
    func present(viewController: SDKOverlayWindowPresentable) {
        viewController.overlayWindow = self
        rootViewController = viewController
        frame = UIScreen.main.bounds
        isHidden = false

        // If we are using scenes, set that up accordingly
        if #available(iOS 13.0, *) {
            if Bundle.main.infoDictionary?["UIApplicationSceneManifest"] != nil {
                if let appWindowScene = UIApplication.shared.connectedScenes.filter({ $0.activationState == .foregroundActive }).first as? UIWindowScene {
                    windowScene = appWindowScene
                }
            }
        }

        makeKeyAndVisible()
    }

    // Dismisses the `SDKOverlayWindow`
    func dismiss() {
        frame = UIScreen.main.bounds
        isHidden = true
        rootViewController = nil

        if #available(iOS 13.0, *) {
            windowScene = nil
        }
    }
}
