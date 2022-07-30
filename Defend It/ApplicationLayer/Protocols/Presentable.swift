//
//  Presentable.swift
//  Defend It
//
//  Created by Роман Сенкевич on 25.07.22.
//

import UIKit.UIViewController

protocol Presentable: AnyObject {
    
    func toPresent() -> UIViewController?
}

extension UIViewController: Presentable {
    
    func toPresent() -> UIViewController? {
        return self
    }
}
