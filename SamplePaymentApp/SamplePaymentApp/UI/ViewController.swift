//
//  ViewController.swift
//  SamplePaymentApp
//
//  Copyright © 2021 Moonsense, Inc. All rights reserved.
//

import UIKit
import SamplePaymentSDK

class ViewController: UIViewController {
    enum Constants {
        static let chocoChipPrice = 4.99
        static let oatmealRaisinPrice = 5.99
        static let taxRate = 0.0825
    }

    @IBOutlet weak var chocoChipView: CookieItemView!
    @IBOutlet weak var oatmealRaisinView: CookieItemView!
    @IBOutlet weak var subtotalLabel: UILabel!
    @IBOutlet weak var taxLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var buyButton: UIButton!

    var chocoChipCookie: Cookie!
    var oatmealRaisinCookie: Cookie!

    override func viewDidLoad() {
        super.viewDidLoad()

        chocoChipCookie = Cookie(name: "Choco Chip", price: Constants.chocoChipPrice, initialQuantity: 1)
        chocoChipView.cookie = chocoChipCookie

        oatmealRaisinCookie = Cookie(name: "Oatmeal Raisin", price: Constants.oatmealRaisinPrice, initialQuantity: 1)
        oatmealRaisinView.cookie = oatmealRaisinCookie

        NotificationCenter.default.addObserver(forName: CookieItemView.cookieChangedNotification, object: nil, queue: .main) { [self] notification in
            updatePrice()
        }

        updatePrice()
    }

    var subtotal: Double = 0.0 {
        didSet {
            subtotalLabel.text = "\(Formatters.Numbers.getCurrencyString(from: subtotal))"
        }
    }

    var tax: Double = 0.0 {
        didSet {
            taxLabel.text = "\(Formatters.Numbers.getCurrencyString(from: tax))"
        }
    }

    var total: Double = 0.0 {
        didSet {
            totalLabel.text = "\(Formatters.Numbers.getCurrencyString(from: total))"
        }
    }

    func updatePrice() {
        subtotal = chocoChipCookie.totalPrice + oatmealRaisinCookie.totalPrice
        tax = subtotal * Constants.taxRate
        total = subtotal + tax
    }

    @IBAction func buyCookies(_ sender: Any) {
        let purchasePrice = Double(Int(total * 100)) / Double(100)

        if purchasePrice > 0 {
            print("Buying cookies for $\(purchasePrice)")
            Payment.capturePayment(price: purchasePrice) { [self] wasCompleted in
                showToast(message: wasCompleted ? "Payment Complete" : "Payment Incomplete", wasSuccessful: wasCompleted)
            }
        }
    }

    func showToast(message : String, wasSuccessful: Bool) {
        let toastLabel = UILabel(frame: CGRect(x: 20,
                                               y: self.view.frame.size.height - 80,
                                               width: self.view.frame.size.width - 40,
                                               height: 64))
        if wasSuccessful {
            toastLabel.backgroundColor = UIColor.MoonsenseColors.toastSuccess
            toastLabel.textColor = UIColor.black
        } else {
            toastLabel.backgroundColor = UIColor.MoonsenseColors.toastFailure
            toastLabel.textColor = UIColor.MoonsenseColors.toastFailureText
        }

        toastLabel.font = UIFont.init(name: "Poppins-SemiBold", size: 12)
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.clipsToBounds  =  true

        self.view.addSubview(toastLabel)

        UIView.animate(withDuration: 2.0, delay: 1.0, options: .curveEaseOut, animations: {
             toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }

    // Set the shouldAutorotate to False
    override open var shouldAutorotate: Bool {
       return false
    }

    // Specify the orientation.
    override open var supportedInterfaceOrientations: UIInterfaceOrientationMask {
       return .portrait
    }
}

