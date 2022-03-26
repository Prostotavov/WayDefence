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
        let dataManager = DataManagerImpl()
        let meadowManager = MeadowManagerImpl(dataManager.battleFieldSize)
        let buildingsManager = BuildingsManagerImpl(dataManager.battleFieldSize)
        let enemiesManager = EnemiesManagerImpl(dataManager.battleFieldSize)
        let decorationManager = DecorationsManagerImpl(dataManager.battleFieldSize)
        
        viewController.output = presenter
        
        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor
        
        interactor.meadowManager = meadowManager
        interactor.buildingsManager = buildingsManager
        interactor.enemiesManager = enemiesManager
        interactor.decorationsManager = decorationManager
        interactor.output = presenter
        
        router.view = viewController
        
    }
    
}
