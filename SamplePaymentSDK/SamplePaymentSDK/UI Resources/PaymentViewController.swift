//
//  PaymentViewController.swift
//  SamplePaymentSDK
//
//  Copyright © 2021 Moonsense, Inc. All rights reserved.
//

import UIKit
import MoonsenseSDK

// The `PaymentViewController` contains the `SwipeToBuyView` and manages the Moonsense
// session while the view is displayed.
class PaymentViewController: UIViewController, SDKOverlayWindowPresentable {
    private enum Constants {
        static let paymentViewHeight = 391.0
        static let animationDuration = 0.5

        // Constants for the subset sensors session
        static let subsetSensorsSessionDuration: TimeInterval = 60.0 * 60.0
        static let subsetSensorsSessionLabel = "ios_payment_sdk_sample_subset_sensors"

        // Constants for the all sensors session
        static let allSensorsSessionDuration: TimeInterval = 30.0
        static let allSensorsSessionLabel = "ios_payment_sdk_sample_all_sensors"
    }

    private enum State {
        case closed
        case open
        var opposite: State {
            switch self {
            case .open: return .closed
            case .closed: return .open
            }
        }
    }

    @IBOutlet weak var blurredView: UIView!
    @IBOutlet weak var paymentView: UIView!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var grabbyBar: UIView!
    @IBOutlet weak var swipeControl: SwipeToBuyView!
    @IBOutlet weak var creditCardEntryView: CreditCardEntryView!
    @IBOutlet weak var expiryEntryView: ExpiryEntryView!
    @IBOutlet weak var cvvEntryView: CVVEntryView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var paymentViewHeightConstraint: NSLayoutConstraint!

    // Settable properties for the PaymentViewController
    var overlayWindow: SDKOverlayWindow?
    var totalPrice: Double = 0.0
    var purchaseCompletion: ((Bool) -> Void)?

    private var swiped = false
    private var subsetSensorsSession: Session?
    private var allSensorsSession: Session?

    override func viewDidLoad() {
        super.viewDidLoad()

        blurredView.alpha = 0

        paymentViewHeightConstraint.constant = Constants.paymentViewHeight

        // The payment view will animate up from the bottom of the view
        paymentView.frame = CGRect(x: 0,
                                   y: paymentView.frame.maxY,
                                   width: paymentView.frame.width,
                                   height: 0)
        paymentView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        paymentView.layer.shadowColor = UIColor.black.cgColor
        paymentView.layer.shadowOpacity = 0.1
        paymentView.layer.shadowRadius = 10

        // Configure gesture recognizers
        paymentView.addGestureRecognizer(panRecognizer)
        paymentView.addGestureRecognizer(doubleTapRecognizer)
        paymentView.addGestureRecognizer(singleTapRecognizer)

        // Set as the delegate for the SwipeToBuyView
        swipeControl.delegate = self

        // Account for the keyboard
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)

        // Watch for text changes
        NotificationCenter.default.addObserver(self, selector: #selector(textDidChange(_:)), name: UITextField.textDidChangeNotification, object: nil)

        // Once the view is configured and prepared to present...

        // Start a long duration Moonsense SDK Session with the subset of available sensors established by the SDKConfig...
        subsetSensorsSession = try? Moonsense.startSession(duration: Constants.subsetSensorsSessionDuration, labels: [Constants.subsetSensorsSessionLabel])

        // ...and then start a second, shorter duration Moonsense SDK Session to capture all available sensors.
        allSensorsSession = try? Moonsense.startSession(duration: Constants.allSensorsSessionDuration,
                                                        sessionConfig: SessionConfig(sensorTypes: SensorType.allCases),
                                                        labels: [Constants.allSensorsSessionLabel])
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let currencyFormatter = NumberFormatter()
        currencyFormatter.numberStyle = .currency
        totalLabel.text = currencyFormatter.string(from: NSNumber(value: totalPrice))

        animateTransitionIfNeeded(to: .open, duration: Constants.animationDuration)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setNeedsUpdateOfHomeIndicatorAutoHidden()
    }

    override var prefersHomeIndicatorAutoHidden: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }

    // MARK: - Keyboard handler
    @objc func keyboardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo else {
            return

        }
        let keyboardScreenEndFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let keyboard = self.view.convert(keyboardScreenEndFrame, from: self.view.window)
        let height = self.view.frame.size.height
        let isHardwareKeyboard = keyboard.size == .zero || ((keyboard.origin.y + keyboard.size.height) > height) || keyboard.size.height < 100

        if !isHardwareKeyboard {
            self.view.frame.origin.y = 0.0 - keyboardScreenEndFrame.height
        }
    }

    @objc func keyboardWillHide(_ notification: Notification) {
        self.view.frame.origin.y = 0
    }

    @objc func textDidChange(_ notification: Notification) {
        swipeControl.setEnabled(shouldEnable: creditCardEntryView.isValid() &&
                                expiryEntryView.isValid() &&
                                cvvEntryView.isValid())
    }

    // MARK: - Animation handling

    // The current state of the animation. This variable is changed only when an animation completes.
    private var currentState: State = .closed

    // All of the currently running animators.
    private var runningAnimators = [UIViewPropertyAnimator]()

    // The progress of each animator. This array is parallel to the `runningAnimators` array.
    private var animationProgress = [CGFloat]()

    private func animateTransitionIfNeeded(to state: State, duration: TimeInterval) {
        guard runningAnimators.isEmpty else { return }

        let transitionAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1, animations: {
            switch state {
            case .open:
                self.blurredView.alpha = 0.8
                self.paymentViewHeightConstraint.constant = Constants.paymentViewHeight
                self.paymentView.layer.cornerRadius = 20
            case .closed:
                self.blurredView.alpha = 0
                self.paymentViewHeightConstraint.constant = 0
                self.paymentView.layer.cornerRadius = 0
            }
            self.view.layoutIfNeeded()
        })

        transitionAnimator.addCompletion { position in
            switch position {
            case .start:
                self.currentState = state.opposite
            case .end:
                self.currentState = state
            case .current:
                fallthrough
            @unknown default:
                ()
            }

            // manually reset the constraint positions when the animator completes based on the state
            switch self.currentState {
            case .open:
                self.blurredView.alpha = 0.8
                self.paymentViewHeightConstraint.constant = Constants.paymentViewHeight
                self.paymentView.layer.cornerRadius = 20
            case .closed:
                // Stop the Moonsense sessions once the payment view is closed
                self.subsetSensorsSession?.stopSession()
                self.allSensorsSession?.stopSession()

                self.blurredView.alpha = 0
                self.paymentViewHeightConstraint.constant = 0
                self.paymentView.layer.cornerRadius = 0
                self.overlayWindow?.dismiss()

                // Invoke the payment completion handler
                DispatchQueue.main.async {
                    if let purchaseCompletion = self.purchaseCompletion {
                        purchaseCompletion(self.swiped)
                    }
                }
            }

            self.runningAnimators.removeAll()
        }

        transitionAnimator.startAnimation()
        runningAnimators.append(transitionAnimator)
    }

    // MARK: - Gesture Recognizers
    private lazy var panRecognizer: UIPanGestureRecognizer = {
        let recognizer = UIPanGestureRecognizer(target: self, action: #selector(paymentViewPanned(recognizer:)))
        return recognizer
    }()

    private lazy var doubleTapRecognizer: UITapGestureRecognizer = {
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(doubleTapped(recognizer:)))
        recognizer.numberOfTapsRequired = 2
        return recognizer
    }()

    private lazy var singleTapRecognizer: UITapGestureRecognizer = {
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(singleTap(recognizer:)))
        recognizer.numberOfTapsRequired = 1
        return recognizer
    }()

    @objc private func singleTap(recognizer: UITapGestureRecognizer) {
        // Dismiss keyboard on a single tap
        self.view.endEditing(true)
    }

    @objc private func doubleTapped(recognizer: UITapGestureRecognizer) {
        // Close the payment view on a double tap
        self.view.endEditing(true)
        animateTransitionIfNeeded(to: .closed, duration: Constants.animationDuration)
    }

    @objc private func paymentViewPanned(recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            self.view.endEditing(true)
            animateTransitionIfNeeded(to: currentState.opposite, duration: Constants.animationDuration)

            // pause all animations, since the next event may be a pan changed
            runningAnimators.forEach { $0.pauseAnimation() }

            // keep track of each animator's progress
            animationProgress = runningAnimators.map { $0.fractionComplete }
        case .changed:
            let translation = recognizer.translation(in: paymentView)
            var fraction = -translation.y / Constants.paymentViewHeight

            // adjust the fraction for the current state and reversed state
            if currentState == .open { fraction *= -1 }
            if runningAnimators[0].isReversed { fraction *= -1 }

            // apply the new fraction
            for (index, animator) in runningAnimators.enumerated() {
                animator.fractionComplete = fraction + animationProgress[index]
            }
        case .ended:
            let translation = recognizer.translation(in: paymentView)
            let shouldClose = (translation.y / Constants.paymentViewHeight) > 0.33

            // reverse the animations based on their current state and pan motion
            switch currentState {
            case .open:
                if !shouldClose && !runningAnimators[0].isReversed { runningAnimators.forEach { $0.isReversed = !$0.isReversed } }
                if shouldClose && runningAnimators[0].isReversed { runningAnimators.forEach { $0.isReversed = !$0.isReversed } }
            case .closed:
                if shouldClose && !runningAnimators[0].isReversed { runningAnimators.forEach { $0.isReversed = !$0.isReversed } }
                if !shouldClose && runningAnimators[0].isReversed { runningAnimators.forEach { $0.isReversed = !$0.isReversed } }
            }

            // continue all animations
            runningAnimators.forEach { $0.continueAnimation(withTimingParameters: nil, durationFactor: 0) }
        default:
            ()
        }
    }
}

extension PaymentViewController: SwipeToBuyViewDelegate {
    func swipeToBuyDidFinish(_ sender: SwipeToBuyView) {
        paymentView.removeGestureRecognizer(panRecognizer)
        swiped = true
        grabbyBar.isHidden = true

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) { [self] in
            swipeControl.isHidden = true
            spinner.startAnimating()

            // Simulate a network processing delay
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) { [self] in
                animateTransitionIfNeeded(to: .closed, duration: Constants.animationDuration)
            }
        }
    }
}
