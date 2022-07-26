//
//  CoordinatorFactoryImpl.swift
//  Defend It
//
//  Created by Роман Сенкевич on 25.07.22.
//

import UIKit.UINavigationController

class CoordinatorFactoryImp: CoordinatorFactory {
    
    func produceBattleCoordinator(router: Router, flowFactory: BattleFlowFactory) -> Coordinator & BattleCoordinatorOutput {
        
        let coordinator = BattleCoordinator(router: router, factory: flowFactory)
        return coordinator
    }
    
    func produceMainCoordinator(router: Router, flowFactory: MainFlowFactory) -> Coordinator & MainCoordinatorOutput {
        
        let coordinator = MainCoordinator(router: router, factory: flowFactory)
        return coordinator
    }

    private func router(_ controller: UINavigationController?) -> Router {
        
        let router = RouterImp(rootController: navigationController(controller))
        return router
    }
    
    private func navigationController(_ controller: UINavigationController?) -> UINavigationController {
        
        if let navigationController = controller {
            return navigationController
        } else {
            return FlowNavigationController()
        }
    }
}
