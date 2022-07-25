//
//  BattleCoordinator.swift
//  Defend It
//
//  Created by Роман Сенкевич on 25.07.22.
//

import Foundation

class BattleCoordinator: BaseCoordinator , BattleCoordinatorOutput {
    
    // MARK: - AuthorizationCoordinatorOutput
    
    var finishFlow: (() -> Void)?
    
    private let factory: BattleFlowFactory
    private let router: Router
    
    init(router: Router, factory: BattleFlowFactory) {
        
        self.factory = factory
        self.router = router
    }
    
    // MARK: - BaseCoordinator
    
    override func start() {
        showLoadBattle()
    }
    
    // MARK: - Flow's controllers

    private func showLoadBattle() {
        let loadBattleOutput = factory.produceLoadBattleOutput()
        loadBattleOutput.onAccept = { [weak self] in
            self?.finishFlow?()
        }
        
        router.setRootModule(loadBattleOutput, hideBar: true)
    }

}
