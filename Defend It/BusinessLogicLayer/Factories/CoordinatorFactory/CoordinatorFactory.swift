//
//  CoordinatorFactory.swift
//  Defend It
//
//  Created by Роман Сенкевич on 25.07.22.
//

import  UIKit.UINavigationController

protocol CoordinatorFactory {
    
    func produceBattleCoordinator(router: Router, flowFactory: BattleFlowFactory) -> Coordinator & BattleCoordinatorOutput
    func produceMainCoordinator(router: Router, flowFactory: MainFlowFactory) -> Coordinator & MainCoordinatorOutput
    func produceBattleMapCoordinator(router: Router, flowFactory: BattleMapFlowFactory) -> Coordinator & BattleMapCoordinatorOutput

}
