//
//  FlowNavigationController.swift
//  Defend It
//
//  Created by Роман Сенкевич on 25.07.22.
//

import UIKit

class FlowNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.isTranslucent = false
        navigationBar.shadowImage = UIImage()
    }
    
    override func popViewController(animated: Bool) -> UIViewController? {
        if #available(iOS 10.0, *) {
            let generator = UIImpactFeedbackGenerator(style: .light)
            generator.impactOccurred()
        }
        let popViewController = super.popViewController(animated: animated)
        return popViewController
    }
}

