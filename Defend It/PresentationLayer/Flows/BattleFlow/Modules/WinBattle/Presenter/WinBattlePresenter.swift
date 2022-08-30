// 
//  WinBattlePresenter.swift
//  Defend It
//
//  Created by Роман Сенкевич on 26.07.22.
//

import Foundation

class WinBattlePresenter: WinBattleViewOutput, WinBattleInteractorOutput {

    weak var view: WinBattleViewInput!
    weak var coordinator: WinBattleViewCoordinatorOutput!
    var interactor: WinBattleInteractorInput!
    
    func viewDidLoad() {
        view.setupInitialState()
        interactor.battlePassed()
    }
    
    func onAcceptTap() {
        coordinator.onAccept?()
    }
}
