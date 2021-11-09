//
//  ExpiryEntryView.swift
//  SamplePaymentSDK
//
//  Copyright © 2021 Moonsense, Inc. All rights reserved.
//

import UIKit

class ExpiryEntryView: UIView {
    private enum Constants {
        static let validExpiryLength = 5
    }

    let nibName = "ExpiryEntryView"

    @IBOutlet weak var expiryTextView: UITextField!

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

        expiryTextView.attributedPlaceholder = NSAttributedString(string: "MM/YY", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        expiryTextView.delegate = self
        expiryTextView.addTarget(self, action: #selector(didChangeText(textField:)), for: .editingChanged)

        self.layer.masksToBounds = true
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 1.0
        self.layer.cornerRadius = 8.0

        self.addSubview(view)
    }

    func isValid() -> Bool {
        return expiryTextView.text?.count == Constants.validExpiryLength
    }

    @objc func didChangeText(textField:UITextField) {
        textField.text = self.formatExpiryString(expiryString: textField.text!)
    }

    func formatExpiryString(expiryString: String) -> String {
        let chars = Array(expiryString.components(separatedBy: "/").joined())

        // Make sure that the first character is correct
        if chars.count == 1 && chars[0] != "0" && chars[0] != "1" {
            return ""
        }

        // Second character can only be one of 0, 1 or 2
        if chars.count == 2 && chars[0] == "1" && !isSecondDateCharValid(character: chars[1]) {
            return String(chars[0])
        }

        // Prevent 00
        if chars.count == 2 && chars[0] == "0" && chars[1] == "0" {
            return "0"
        }

        var formattedExpiryString = ""

        if(chars.count > 0) {
            for i in 0..<chars.count {
                formattedExpiryString.append(chars[i])
                if((i+1) % 2 == 0 && i+1 != chars.count){
                    formattedExpiryString.append("/")
                }
            }
        }

        return formattedExpiryString
    }

    func isSecondDateCharValid(character: Character) -> Bool {
        return character == "0" || character == "1" || character == "2"
    }
}

extension ExpiryEntryView: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.layer.borderColor = UIColor.MoonsenseColors.purple.cgColor
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        self.layer.borderColor = UIColor.lightGray.cgColor
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let newLength = (textField.text ?? "").count + string.count - range.length
        return newLength <= Constants.validExpiryLength
    }
}
