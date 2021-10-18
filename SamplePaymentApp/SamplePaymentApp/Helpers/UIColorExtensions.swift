//
//  UIColorExtensions.swift
//  SamplePaymentApp
//
//  Copyright © 2021 Moonsense, Inc. All rights reserved.
//

import UIKit

extension UIColor {

    enum MoonsenseColors {
        static let toastSuccess = UIColor.init(rgb: 0x1FCC5F)
        static let toastFailure = UIColor.init(rgb: 0xFFCCCC)
        static let toastFailureText = UIColor.init(rgb: 0xFF0000)
    }

    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")

        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }

    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }

}
