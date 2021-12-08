//
//  CreditCardEntryView.swift
//  SamplePaymentSDK
//
//  Copyright © 2021 Moonsense, Inc. All rights reserved.
//

import UIKit

class CreditCardEntryView: UIView {
    private enum Constants {
        static let validCardLength = 19
    }

    let nibName = "CreditCardEntryView"

    @IBOutlet weak var creditCardTextView: UITextField!

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

        creditCardTextView.attributedPlaceholder = NSAttributedString(string: "**** **** **** ****", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        creditCardTextView.delegate = self
        creditCardTextView.addTarget(self, action: #selector(didChangeText(textField:)), for: .editingChanged)

        self.layer.masksToBounds = true
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 1.0
        self.layer.cornerRadius = 8.0

        self.addSubview(view)
    }

    @objc func didChangeText(textField:UITextField) {
        textField.text = self.formatCreditCardString(creditCardString: textField.text!)
    }

    func isValid() -> Bool {
        return creditCardTextView.text?.count == Constants.validCardLength
    }

    func formatCreditCardString(creditCardString: String) -> String {
        let chars = Array(creditCardString.components(separatedBy: .whitespaces).joined())
        var formattedCreditCardString = ""

        if(chars.count > 0) {
            for i in 0..<chars.count {
                formattedCreditCardString.append(chars[i])
                if((i+1) % 4 == 0 && i+1 != chars.count){
                    formattedCreditCardString.append(" ")
                }
            }
        }
        return formattedCreditCardString
    }
}

extension CreditCardEntryView: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.layer.borderColor = UIColor.MoonsenseColors.purple.cgColor
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        self.layer.borderColor = UIColor.lightGray.cgColor
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if !string.isEmpty && !string.replacingOccurrences(of: " ", with: "").isNumeric {
            return false
        }

        let newLength = (textField.text ?? "").count + string.count - range.length
        return newLength <= Constants.validCardLength
    }
}
