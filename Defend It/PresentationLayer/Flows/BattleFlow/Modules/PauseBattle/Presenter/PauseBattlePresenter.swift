// 
//  PauseBattlePresenter.swift
//  Defend It
//
//  Created by Роман Сенкевич on 26.07.22.
//

import Foundation

class PauseBattlePresenter: PauseBattleViewOutput, PauseBattleInteractorOutput {

    weak var view: PauseBattleViewInput!
    weak var coordinator: PauseBattleViewCoordinatorOutput!
    var interactor: PauseBattleInteractorInput!
    
    func viewDidLoad() {
        view.setupInitialState()
    }
    
    func onPlayTap() {
        coordinator.onPlay?()
    }
    
    func goToHomePagePressed() {
        coordinator.onQuit?()
    }
}
