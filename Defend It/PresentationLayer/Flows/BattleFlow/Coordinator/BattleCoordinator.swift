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
            self?.showBattleField()
        }
        
        router.setRootModule(loadBattleOutput, hideBar: true)
    }
    
    private func showBattleField() {
        let battleFieldOutput = factory.produceBattleFieldOutput()
        
        battleFieldOutput.onFinishBattle = { [weak self] in
            self?.showLoseBattle()
        }
        battleFieldOutput.onWinBattle = { [weak self] in
            self?.showWinBattle()
        }
        battleFieldOutput.onLoseBattle = { [weak self] in
            self?.showLoseBattle()
        }
        
        router.push(battleFieldOutput, animated: false)
    }
    
    private func showLoseBattle() {
        let loseBattleOutput = factory.produceLoseBattleOutput()
        loseBattleOutput.onAccept = { [weak self] in
            self?.finishFlow?()
        }
        
        router.push(loseBattleOutput, animated: false)
    }
    
    private func showWinBattle() {
        let winBattleOutput = factory.produceWinBattleOutput()
        winBattleOutput.onAccept = { [weak self] in
            self?.finishFlow?()
        }
        
        router.push(winBattleOutput, animated: false)
    }

}
