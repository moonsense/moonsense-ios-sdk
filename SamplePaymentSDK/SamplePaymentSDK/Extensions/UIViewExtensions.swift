//
//  UIViewExtensions.swift
//  SamplePaymentSDK
//
//  Copyright © 2021 Moonsense, Inc. All rights reserved.
//

import UIKit

extension UIView {
    func loadViewFromNib(_ nibName: String, owner: AnyObject) -> UIView? {
        let nib = UINib(nibName: nibName, bundle: Payment.frameworkBundle())
        return nib.instantiate(withOwner: owner, options: nil).first as? UIView
    }
}
