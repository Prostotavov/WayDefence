// 
//  BattleFieldAssembly.swift
//  Defend It
//
//  Created by MacBook Pro on 16.03.22.
//

import UIKit

class BattleFieldAssembly: NSObject, BattleFieldAssemblyProtocol {
    
    func assembly(with viewController: BattleFieldViewController) {
        
        // init viper modules
        let presenter = BattleFieldPresenter()
        let interactor = BattleFieldInteractor()
        let router = BattleFieldRouter()
        
        // init managers
        let dataManager = DataManagerImpl()
        let meadowManager = MeadowManagerImpl(dataManager.battleFieldSize)
        let buildingsManager = BuildingsManagerImpl(dataManager.battleFieldSize)
        let enemiesManager = EnemiesManagerImpl(dataManager.battleFieldSize)
        let battleValuesManager = BattleManagerImpl()
        let camerasManager = CamerasManagerImpl()
        
        // init and assembly battle
        let battle = BattleImpl()
        battle.meadowManager = meadowManager
        battle.enemiesManager = enemiesManager
        battle.buildingsManager = buildingsManager
        battle.battleValuesManager = battleValuesManager
        battle.delegate = interactor
        
        // assembly in/out for viper modules
        viewController.output = presenter
        
        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor
        
        interactor.battle = battle
        interactor.camerasManager = camerasManager
        interactor.output = presenter
        
        router.view = viewController
        
        // assembly delegates for managers
        buildingsManager.delegate = battle
        enemiesManager.delegate = battle
        meadowManager.delegate = battle
        
    }
    
}
