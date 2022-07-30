//
//  TabbarCoordinator.swift
//  Defend It
//
//  Created by Роман Сенкевич on 28.07.22.
//

import UIKit

class TabbarCoordinator: BaseCoordinator, TabbarCoordinatorOutput {
    

    var finishFlow: (() -> Void)?
    var startBattleFlow: (() -> Void)?
    
    private weak var tabbarOutput: (FlowTabbarCoordinatorOutput)?
    private let coordinatorFactory: CoordinatorFactory
    
    init(tabbarOutput: FlowTabbarCoordinatorOutput, coordinatorFactory: CoordinatorFactory) {
        
        self.tabbarOutput = tabbarOutput
        self.coordinatorFactory = coordinatorFactory
    }
    
    override func start() {
        
        tabbarOutput!.onMainFlow = runMainFlow()
        tabbarOutput!.onBattleMapFlow = runBattleMapFlow()
    }
    
    private func runMainFlow() -> ((UINavigationController) -> ()) {
        
        return { navigationController in
            
            let mainCoordinator = self.coordinatorFactory.produceMainCoordinator(navigationController: navigationController, flowFactory: FlowFactoryImp.defaultFactory)
            
            mainCoordinator.finishFlow = { [weak self, weak mainCoordinator] in
                self?.startBattleFlow?()
                self?.removeDependency(mainCoordinator)
            }
            
            self.addDependency(mainCoordinator)
            mainCoordinator.start()
        }
    }
    
    private func runBattleMapFlow() -> ((UINavigationController) -> ()) {
        
        return { navigationController in
            
            let battleMapCoordinator = self.coordinatorFactory.produceBattleMapCoordinator(navigationController: navigationController, flowFactory: FlowFactoryImp.defaultFactory)
            
            battleMapCoordinator.finishFlow = { [weak self, weak battleMapCoordinator] in
                self?.startBattleFlow?()
                self?.removeDependency(battleMapCoordinator)
            }
            battleMapCoordinator.start()
            self.addDependency(battleMapCoordinator)
        }
    }
}
