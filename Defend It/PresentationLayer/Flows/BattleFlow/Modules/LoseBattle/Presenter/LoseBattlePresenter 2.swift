// 
//  LoseBattlePresenter.swift
//  Defend It
//
//  Created by Роман Сенкевич on 26.07.22.
//

import Foundation

class LoseBattlePresenter: LoseBattleViewOutput, LoseBattleInteractorOutput {

    weak var view: LoseBattleViewInput!
    weak var coordinator: LoseBattleViewCoordinatorOutput!
    var interactor: LoseBattleInteractorInput!
    
    func viewDidLoad() {
        view.setupInitialState()
    }
    
    func onAcceptTap() {
        coordinator.onAccept?()
    }
}
