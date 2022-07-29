// 
//  BattleMapPresenter.swift
//  Defend It
//
//  Created by Роман Сенкевич on 26.07.22.
//

import Foundation

class BattleMapPresenter: BattleMapViewOutput, BattleMapInteractorOutput {

    weak var view: BattleMapViewInput!
    weak var coordinator: BattleMapViewCoordinatorOutput!
    var interactor: BattleMapInteractorInput!
    
    func viewDidLoad() {
        view.setupInitialState()
    }
    
    func onBattleIconPressed() {
        coordinator.onBattleIcon?()
    }
    
    func battleIconPressed(byId id: Int) {
        
        interactor.battleIconPressed(byId: id)
    }
}
