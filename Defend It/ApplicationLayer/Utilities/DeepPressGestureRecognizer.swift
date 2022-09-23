//
//  DeepPressGestureRecognizer.swift
//  Defend It
//
//  Created by Роман Сенкевич on 20.09.22.
//

import UIKit
import UIKit.UIGestureRecognizerSubclass
import AudioToolbox

class DeepPressGestureRecognizer: UIGestureRecognizer {
    var vibrateOnDeepPress = true
    var threshold: CGFloat = 0.75
    var hardTriggerMinTime: TimeInterval = 0.5

    var onDeepPress: (() -> Void)?

    private var deepPressed: Bool = false {
        didSet {
            if (deepPressed && deepPressed != oldValue) {
                onDeepPress?()
            }
        }
    }

    private var k_PeakSoundID: UInt32 = 1519
    private var hardAction: Selector?
    private var target: AnyObject?
    
    init() {
        super.init(target: nil, action: nil)
    }

    required init(target: AnyObject?, action: Selector, hardAction: Selector? = nil, threshold: CGFloat = 0.75) {
        self.target = target
        self.hardAction = hardAction
        self.threshold = threshold

        super.init(target: target, action: action)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        if let touch = touches.first {
            handle(touch: touch)
        }
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {
        if let touch = touches.first {
            handle(touch: touch)
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesEnded(touches, with: event)
        state = deepPressed ? UIGestureRecognizer.State.ended : UIGestureRecognizer.State.failed
        deepPressed = false
    }

    private func handle(touch: UITouch) {
        guard let _ = view, touch.force != 0 && touch.maximumPossibleForce != 0 else {
            return
        }
        
        let forcePercentage = (touch.force / touch.maximumPossibleForce)

        if !deepPressed && forcePercentage >= threshold {
            state = UIGestureRecognizer.State.began
            if vibrateOnDeepPress {
                AudioServicesPlaySystemSound(k_PeakSoundID)
            }
            deepPressed = true

        } else if deepPressed && forcePercentage <= 0 {
            endGesture()

        } else if deepPressed && forcePercentage <= 0.2 {
            deepPressed = false
        }
    }

    func endGesture() {
        state = UIGestureRecognizer.State.ended
        deepPressed = false
    }
}

// MARK: DeepPressable protocol extension
protocol DeepPressable {
    var gestureRecognizers: [UIGestureRecognizer]? {get set}

    func addGestureRecognizer(gestureRecognizer: UIGestureRecognizer)
    func removeGestureRecognizer(gestureRecognizer: UIGestureRecognizer)

    func setDeepPressAction(target: AnyObject, action: Selector)
    func removeDeepPressAction()
}

extension DeepPressable {

    func setDeepPressAction(target: AnyObject, action: Selector) {
        let deepPressGestureRecognizer = DeepPressGestureRecognizer(target: target, action: action, threshold: 0.75)
        self.addGestureRecognizer(gestureRecognizer: deepPressGestureRecognizer)
    }

    func removeDeepPressAction() {
        guard let gestureRecognizers = gestureRecognizers else { return }

        for recogniser in gestureRecognizers where recogniser is DeepPressGestureRecognizer {
            removeGestureRecognizer(gestureRecognizer: recogniser)
        }
    }
}


