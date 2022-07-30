//
//  CoordinatorFactory.swift
//  Defend It
//
//  Created by Роман Сенкевич on 25.07.22.
//

import  UIKit.UINavigationController

protocol CoordinatorFactory {

    
    func produceTabbarCoordinator(coordinatorFactory: CoordinatorFactory) -> (configurator: Coordinator & TabbarCoordinatorOutput, toPresent: Presentable?)
    func produceBattleCoordinator(router: Router, flowFactory: BattleFlowFactory) -> Coordinator & BattleCoordinatorOutput
    
    // MARK: - Main
    func produceMainCoordinator(flowFactory: MainFlowFactory) -> Coordinator & MainCoordinatorOutput
    func produceMainCoordinator(navigationController: UINavigationController?, flowFactory: MainFlowFactory) -> Coordinator & MainCoordinatorOutput
    func produceMainCoordinator(router: Router, flowFactory: MainFlowFactory) -> Coordinator & MainCoordinatorOutput
    
    // MARK: - BattleMap
    func produceBattleMapCoordinator(flowFactory: BattleMapFlowFactory) -> Coordinator
    func produceBattleMapCoordinator(navigationController: UINavigationController?, flowFactory: BattleMapFlowFactory) -> Coordinator & BattleMapCoordinatorOutput
    func produceBattleMapCoordinator(router: Router, flowFactory: BattleMapFlowFactory) -> Coordinator & BattleMapCoordinatorOutput

    
}
