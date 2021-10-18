//
//  SDKOverlayWindowPresentable.swift
//  SamplePaymentSDK
//
//  Copyright © 2021 Moonsense, Inc. All rights reserved.
//

import UIKit

protocol SDKOverlayWindowPresentable where Self: UIViewController {
    var overlayWindow: SDKOverlayWindow? { get set }
}
