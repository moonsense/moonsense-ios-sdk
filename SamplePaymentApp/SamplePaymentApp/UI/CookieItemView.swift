//
//  CookieItemView.swift
//  SamplePaymentApp
//
//  Copyright © 2021 Moonsense, Inc. All rights reserved.
//

import UIKit

class CookieItemView: UIView {

    static let cookieChangedNotification = NSNotification.Name("CookieQuantityChanged")

    @IBOutlet weak var cookieNameLabel: UILabel!
    @IBOutlet weak var cookieQuantityLabel: UILabel!
    @IBOutlet weak var cookiePriceLabel: UILabel!
    @IBOutlet weak var addCookieButton: UIButton!
    @IBOutlet weak var removeCookieButton: UIButton!

    let nibName = "CookieItemView"

    var cookie: Cookie! {
        didSet {
            cookieNameLabel.text = cookie.name

            updateView()
        }
    }

    @IBAction func addCookie(_ sender: Any) {
        cookie.addCookie()
        updateView()
    }

    @IBAction func removeCookie(_ sender: Any) {
        cookie.removeCookie()
        updateView()
    }

    private func updateView() {
        cookieQuantityLabel.text = "\(cookie.quantity)"
        cookiePriceLabel.text = "\(Formatters.Numbers.getCurrencyString(from: cookie.totalPrice))"
        removeCookieButton.isEnabled = !(cookie.quantity == 0)

        NotificationCenter.default.post(name: CookieItemView.cookieChangedNotification, object: self)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    func commonInit() {
        guard let view = loadViewFromNib() else { return }
        view.frame = self.bounds
        self.addSubview(view)
    }

    func loadViewFromNib() -> UIView? {
        let nib = UINib(nibName: nibName, bundle: nil)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
}
