//
//  ViewController.swift
//  SampleCoreApp
//
//  Copyright © 2022 Moonsense, Inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var textView: UITextView!

    private let acmeSDK = AcmeSDK()
    private var acmeServer: AcmeServer?

    override func viewDidLoad() {
        super.viewDidLoad()

        acmeServer = AcmeServer(delegate: self)
    }

    @IBAction func recordSession(_ sender: Any) {
        acmeSDK.record()
    }

    func displayData(_ data: String) {
        DispatchQueue.main.async {
            self.textView.text.append(contentsOf: "\(data)\n")
            self.textView.scrollRangeToVisible(NSRange(location: self.textView.text.count - 1, length: 0))
        }
    }
}

extension ViewController: AcmeServerDelegate {
    func receivedData(sessionId: String, count: Int) {
        displayData("Session \(sessionId) received \(count) samples\n")
    }
}
