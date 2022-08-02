// 
//  BattleFieldAssembly.swift
//  Defend It
//
//  Created by MacBook Pro on 16.03.22.
//

import UIKit

protocol BattleFieldAssemblyDelagate: AnyObject {
    func createViperModelues(completed percent: Float)
    func createBattleMission(completed percent: Float)
    func createManagers(completed percent: Float)
    func loadBattleLogic(completed percent: Float)
    func viewAssemblyDone()
}

class BattleFieldAssembly: NSObject, BattleFieldAssemblyProtocol {
    
    weak var delegate: BattleFieldAssemblyDelagate!
    
    func setDelegate(delegate: BattleFieldAssemblyDelagate) {
        self.delegate = delegate
    }
    
    func assemblyModuleForViewInput<UIViewController>(viewInput: UIViewController) {
        if let viewController = viewInput as? BattleFieldViewController {
            assembly(viewController: viewController)
        }
    }
    
    private func assembly(viewController: BattleFieldViewController) {
        
        // init viper modules
        let presenter = BattleFieldPresenter()
        let interactor = BattleFieldInteractor()
        delegate.createViperModelues(completed: 5)        // 5% load
        
        
        let battleMission = FactoryBattleMission().createBattleMission(id: CurrentBattleImp.shared.chosenBattleMission)
        delegate.createBattleMission(completed: 17)       // 22% load
        
        // init managers
        let meadowManager = MeadowManagerImpl(ground: battleMission.battleMeadow)
        let buildingsManager = BuildingsManagerImpl(battleMission.battleFieldSize)
        let enemiesManager = EnemiesManagerImpl(battleMission.battleFieldSize)
        let battleValuesManager = BattleManagerImpl(battleValues: battleMission.battleValues)
        let camerasManager = SceneCamera()
        delegate.createManagers(completed: 33)           // 65% load
        
        
        enemiesManager.battleMision = battleMission
        battleMission.wavesCreator.delegate = enemiesManager
        
        // init and assembly battle
        let battle = BattleImpl()
        delegate.loadBattleLogic(completed: 27)           // 82% load
        battle.meadowManager = meadowManager
        battle.enemiesManager = enemiesManager
        battle.buildingsManager = buildingsManager
        battle.battleValuesManager = battleValuesManager
        battle.delegate = interactor
        battle.battleMission = battleMission
        
        // assembly in/out for viper modules
        viewController.output = presenter
        
        presenter.view = viewController
        presenter.interactor = interactor
        presenter.coordinator = viewController
        
        interactor.battle = battle
        interactor.output = presenter
        
        // assembly delegates for managers
        buildingsManager.delegate = battle
        enemiesManager.delegate = battle
        meadowManager.delegate = battle
        battleValuesManager.delegate = battle
        
        delegate.viewAssemblyDone()                     // 100% load
    }
    
}
