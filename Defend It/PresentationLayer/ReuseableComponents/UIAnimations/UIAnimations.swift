//
//  UIAnimations.swift
//  Defend It
//
//  Created by Роман Сенкевич on 1.09.22.
//

import UIKit

struct UIAnimations {
    
    
    private static var counter: Int = 0
    
    static func rapidIncreaseAndDecreaseAnimation(view: UIView) {
        if counter == 0 {
            counter += 1
        } else {
            return
        }
        UIView.animateKeyframes(withDuration: 0.5, delay: 0, options: .calculationModeLinear, animations: {
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.3) {
                view.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.3, relativeDuration: 0.3) {
                view.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.6, relativeDuration: 0.3) {
                view.transform = CGAffineTransform.identity
            }
            
        }, completion: nil)
    }
    
    static func bagButtonSizeReductionAnimation(view: UIView) {
        counter = 0
        UIView.animateKeyframes(withDuration: 0.2, delay: 0, options: .calculationModeLinear, animations: {
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1) {
                view.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            }
            
        }, completion: nil)
    }
}
