//
//  CoordinatorFactoryImpl.swift
//  Defend It
//
//  Created by Роман Сенкевич on 25.07.22.
//

import UIKit.UINavigationController

class CoordinatorFactoryImp: CoordinatorFactory {
    
    static let defaultFactory = CoordinatorFactoryImp()
    
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
    
    func produceTabbarCoordinator(coordinatorFactory: CoordinatorFactory) -> (configurator: Coordinator & TabbarCoordinatorOutput, toPresent: Presentable?) {
        
        let controller = FlowTabbarController()
        let coordinator = TabbarCoordinator(tabbarOutput: controller, coordinatorFactory: coordinatorFactory)
        return (coordinator, controller)
    }
    
    func produceBattleCoordinator(router: Router, flowFactory: BattleFlowFactory) -> Coordinator & BattleCoordinatorOutput {
        
        let coordinator = BattleCoordinator(router: router, factory: flowFactory)
        return coordinator
    }
    
}

// MARK: - Main
extension CoordinatorFactoryImp {
    func produceMainCoordinator(flowFactory: MainFlowFactory) -> Coordinator & MainCoordinatorOutput {
        
        let coordinator = produceMainCoordinator(navigationController: nil, flowFactory: flowFactory)
        return coordinator
    }
    
    func produceMainCoordinator(navigationController: UINavigationController?, flowFactory: MainFlowFactory) -> Coordinator & MainCoordinatorOutput {
        
        let coordinator = produceMainCoordinator(router: router(navigationController), flowFactory: flowFactory)
        return coordinator
    }
    
    func produceMainCoordinator(router: Router, flowFactory: MainFlowFactory) -> Coordinator & MainCoordinatorOutput {
        
        let coordinator = MainCoordinator(router: router, factory: flowFactory)
        return coordinator
    }
    
}

// MARK: - BattleMap
extension CoordinatorFactoryImp {
    func produceBattleMapCoordinator(flowFactory: BattleMapFlowFactory) -> Coordinator {
        
        let coordinator = produceBattleMapCoordinator(navigationController: nil, flowFactory: flowFactory)
        return coordinator
    }
    
    func produceBattleMapCoordinator(navigationController: UINavigationController?, flowFactory: BattleMapFlowFactory) -> Coordinator & BattleMapCoordinatorOutput {
        
        let coordinator = produceBattleMapCoordinator(router: router(navigationController), flowFactory: flowFactory)
        return coordinator
    }
    
    func produceBattleMapCoordinator(router: Router, flowFactory: BattleMapFlowFactory) -> Coordinator & BattleMapCoordinatorOutput {
        
        let coordinator = BattleMapCoordinator(router: router, factory: flowFactory)
        return coordinator
    }
}
