//
//  FlowTabbarCoordinatorOutput.swift
//  Defend It
//
//  Created by Роман Сенкевич on 28.07.22.
//

import UIKit.UINavigationController

protocol FlowTabbarCoordinatorOutput: AnyObject {
    
    var onMainFlow: ((UINavigationController) -> ())? { get set }
    var onBattleMapFlow: ((UINavigationController) -> ())? { get set }
    func viewDidLoad()
}

