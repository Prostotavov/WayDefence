// 
//  BattleFieldAssembly.swift
//  Defend It
//
//  Created by MacBook Pro on 16.03.22.
//

import UIKit

class BattleFieldAssembly: NSObject, BattleFieldAssemblyProtocol {
    
    func assembly(with viewController: BattleFieldViewController) {
        
        let presenter = BattleFieldPresenter()
        let interactor = BattleFieldInteractor()
        let router = BattleFieldRouter()
        
        // managers
        let dataManager = DataManagerImpl()
        let meadowManager = MeadowManagerImpl(dataManager.battleFieldSize)
        let buildingsManager = BuildingsManagerImpl(dataManager.battleFieldSize)
        let enemiesManager = EnemiesManagerImpl(dataManager.battleFieldSize)
        let battleValuesManager = BattleValuesManagerImpl()
        let camerasManager = CamerasManagerImpl()
        
        viewController.output = presenter
        
        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor
        
        interactor.meadowManager = meadowManager
        interactor.buildingsManager = buildingsManager
        interactor.enemiesManager = enemiesManager
        interactor.battleValuesManager = battleValuesManager
        interactor.camerasManager = camerasManager
        interactor.output = presenter
        
        router.view = viewController
        
        buildingsManager.delegate = interactor
        enemiesManager.delegate = interactor
        
    }
    
}
