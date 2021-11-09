//
//  SwipeToBuyView.swift
//  SamplePaymentSDK
//
//  Copyright © 2021 Moonsense, Inc. All rights reserved.
//
import UIKit

// The `SwipeToBuyViewDelegate` alerts the delegate when the swipe has completed.
protocol SwipeToBuyViewDelegate: AnyObject {
    func swipeToBuyDidFinish(_ sender: SwipeToBuyView)
}

// The `SwipeToBuyView` implements the Swipe To Buy UI control.
class SwipeToBuyView: UIView {
    private enum Constants {
        static let animationDuration = 0.2
        static let xStartingPoint = 8.0
        static let completionThreshold = 0.95
    }

    let nibName = "SwipeToBuyView"

    @IBOutlet weak var disabledOverlay: UIView!
    @IBOutlet weak var swipeToBuyLabel: UILabel!
    @IBOutlet weak var slider: UIView!
    @IBOutlet weak var sliderImageView: UIImageView!
    @IBOutlet weak var leadingSliderConstraint: NSLayoutConstraint!

    private var isFinished: Bool = false
    weak var delegate: SwipeToBuyViewDelegate?

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
        self.layer.cornerRadius = self.bounds.height / 2
        view.layer.cornerRadius = view.bounds.width / 2

        let pangestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePan(recognizer:)))
        slider.addGestureRecognizer(pangestureRecognizer)
        slider.layer.cornerRadius = slider.bounds.width / 2

        disabledOverlay.layer.cornerRadius = disabledOverlay.bounds.height / 2

        setEnabled(shouldEnable: false)

        self.addSubview(view)
    }

    func setEnabled(shouldEnable: Bool) {
        disabledOverlay.isHidden = shouldEnable
    }

    var animator = UIViewPropertyAnimator()

    private var xEndingPoint: CGFloat {
        get {
            return (self.bounds.maxX - Constants.xStartingPoint - slider.bounds.width)
        }
    }

    private func updateSliderXPosition(_ x: CGFloat) {
        leadingSliderConstraint.constant = x
        setNeedsLayout()
    }

    @objc private func handlePan(recognizer: UIPanGestureRecognizer) {
        if isFinished {
            return
        }

        let translatedPoint = recognizer.translation(in: slider).x
        switch recognizer.state {
        case .began:
            break
        case .changed:
            if translatedPoint >= xEndingPoint {
                return
            }
            if translatedPoint <= Constants.xStartingPoint {
                updateSliderXPosition(Constants.xStartingPoint)
                return
            }
            updateSliderXPosition(translatedPoint)
            break
        case .ended:
            if translatedPoint >= xEndingPoint * Constants.completionThreshold {
                updateSliderXPosition(xEndingPoint)
                UIView.animate(withDuration: Constants.animationDuration) {
                    self.sliderImageView.image = UIImage(named: "CheckMark", in: Payment.frameworkBundle(), compatibleWith: nil)
                    self.slider.backgroundColor = UIColor.MoonsenseColors.success
                    self.swipeToBuyLabel.textColor = UIColor.MoonsenseColors.success
                    self.layoutIfNeeded()
                }

                // Finish action
                isFinished = true
                delegate?.swipeToBuyDidFinish(self)
                return
            }
            if translatedPoint <= Constants.xStartingPoint {
                updateSliderXPosition(Constants.xStartingPoint)
                return
            }
            UIView.animate(withDuration: Constants.animationDuration) {
                self.leadingSliderConstraint.constant = Constants.xStartingPoint
                self.layoutIfNeeded()
            }
        default:
            ()
        }
    }
}
