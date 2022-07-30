//
//  ApplicationCoordinator.swift
//  Defend It
//
//  Created by Роман Сенкевич on 25.07.22.
//

import Foundation
import UIKit

final class ApplicationCoordinator: BaseCoordinator {

    private let flowFactory: FlowFactoryImp
    private let coordinatorFactory: CoordinatorFactory
    private let router: Router

    init(router: Router,
         coordinatorFactory: CoordinatorFactory,
         flowFactory: FlowFactoryImp) {

        self.router = router
        self.coordinatorFactory = coordinatorFactory
        self.flowFactory = flowFactory
    }

    override func start() {
        runTabbarFlow()
    }
    
    private func runMainFlow() {

        let coordinator = coordinatorFactory.produceMainCoordinator(router: router, flowFactory: flowFactory)

        coordinator.finishFlow = { [weak self, weak coordinator] in
            self?.runBattleFlow()
            self?.removeDependency(coordinator)
        }

        addDependency(coordinator)
        coordinator.start()
    }

    private func runBattleFlow() {
        
        let coordinator = coordinatorFactory.produceBattleCoordinator(router: router, flowFactory: flowFactory)
        
        coordinator.finishFlow = { [weak self, weak coordinator] in
            self?.runTabbarFlow()
            self?.removeDependency(coordinator)
        }

        addDependency(coordinator)
        coordinator.start()
    }
    
    private func runTabbarFlow() {
        
         let (coordinator, module) = coordinatorFactory.produceTabbarCoordinator(coordinatorFactory: coordinatorFactory)
        
        coordinator.finishFlow = { [weak self, weak coordinator] in
            self?.runMainFlow()
            self?.removeDependency(coordinator)
        }
        coordinator.startBattleFlow = { [weak self, weak coordinator] in
            self?.runBattleFlow()
            self?.removeDependency(coordinator)
        }
        
        addDependency(coordinator)
        router.setRootModule(module, hideBar: true)
        coordinator.start()
    }

}

