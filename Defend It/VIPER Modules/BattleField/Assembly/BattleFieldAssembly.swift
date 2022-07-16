// 
//  BattleFieldAssembly.swift
//  Defend It
//
//  Created by MacBook Pro on 16.03.22.
//

import UIKit

protocol BattleFieldAssemblyDelagate: AnyObject {
    func viperModulesInitCompleted()
    func managersInitCompleted()
    func battleMissionCreated()
    func battleLogicCreated()
    func viewAssemblyCompleted()
}

class BattleFieldAssembly: NSObject, BattleFieldAssemblyProtocol {
    
    weak var delegate: BattleFieldAssemblyDelagate!
    
    func setDelegate(delegate: BattleFieldAssemblyDelagate) {
        self.delegate = delegate
    }
    
    func assembly(with viewController: BattleFieldViewController) {
        
        // init viper modules
        let presenter = BattleFieldPresenter()
        let interactor = BattleFieldInteractor()
        let router = BattleFieldRouter()
        delegate.viperModulesInitCompleted()
        
        
        let battleMission = Battle01()
        delegate.battleMissionCreated()
        
        // init managers
        let meadowManager = MeadowManagerImpl(ground: battleMission.battleMeadow)
        let buildingsManager = BuildingsManagerImpl(battleMission.battleFieldSize)
        let enemiesManager = EnemiesManagerImpl(battleMission.battleFieldSize)
        let battleValuesManager = BattleManagerImpl(battleValues: battleMission.battleValues)
        let camerasManager = CamerasManagerImpl()
        delegate.managersInitCompleted()
        
        
        // init and assembly battle
        let battle = BattleImpl()
        delegate.battleLogicCreated()
        battle.meadowManager = meadowManager
        battle.enemiesManager = enemiesManager
        battle.buildingsManager = buildingsManager
        battle.battleValuesManager = battleValuesManager
        battle.delegate = interactor
        battle.battleMission = battleMission
        
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
        battleValuesManager.delegate = battle
        
        delegate.viewAssemblyCompleted()
    }
    
}
