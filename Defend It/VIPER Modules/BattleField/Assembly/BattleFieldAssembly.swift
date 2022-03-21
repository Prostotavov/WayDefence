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
        let enemyPathManager = EnemyPathManagerImpl()
        
        viewController.output = presenter
        
        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor
        
        interactor.enemyPathManager = enemyPathManager
        interactor.output = presenter
        
        router.view = viewController
        
    }
    
}
