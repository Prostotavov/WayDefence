//
//  BattleMapCoordinator.swift
//  Defend It
//
//  Created by Роман Сенкевич on 28.07.22.
//

import Foundation

class BattleMapCoordinator: BaseCoordinator , BattleMapCoordinatorOutput {
    
    // MARK: - AuthorizationCoordinatorOutput
    
    var finishFlow: (() -> Void)?
    
    private let factory: BattleMapFlowFactory
    private let router: Router
    
    init(router: Router, factory: BattleMapFlowFactory) {
        
        self.factory = factory
        self.router = router
    }
    
    // MARK: - BaseCoordinator
    
    override func start() {
        showBattleMap()
    }
    
    // MARK: - Flow's controllers

    private func showBattleMap() {
        let battleMapOutput = factory.produceBattleMapOutput()
        battleMapOutput.onBattleIcon = { [weak self] in
            self?.finishFlow?()
        }

        router.setRootModule(battleMapOutput, hideBar: true)
    }
    


}
