//
//  CVVEntryView.swift
//  SamplePaymentSDK
//
//  Copyright © 2021 Moonsense, Inc. All rights reserved.
//

import UIKit

class CVVEntryView: UIView {
    private enum Constants {
        static let validCVVLength = 3
    }

    let nibName = "CVVEntryView"

    @IBOutlet weak var cvvTextView: UITextField!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    func commonInit() {
        guard let view = loadViewFromNib(nibName, owner: self) else { return }
        view.frame = self.bounds

        cvvTextView.attributedPlaceholder = NSAttributedString(string: "CVV", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        cvvTextView.delegate = self

        self.layer.masksToBounds = true
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 1.0
        self.layer.cornerRadius = 8.0

        self.addSubview(view)
    }

    func isValid() -> Bool {
        return cvvTextView.text?.count == Constants.validCVVLength
    }
}

extension CVVEntryView: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.layer.borderColor = UIColor.MoonsenseColors.purple.cgColor
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        self.layer.borderColor = UIColor.lightGray.cgColor
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if !string.isEmpty && !string.isNumeric {
            return false
        }

        let newLength = (textField.text ?? "").count + string.count - range.length
        return newLength <= Constants.validCVVLength
    }
}
