//
//  LoadBattlePresenter.swift
//  Defend It
//
//  Created by Роман Сенкевич on 25.07.22.
//

import Foundation

class LoadBattlePresenter: LoadBattleViewOutput, LoadBattleInteractorOutput {

    weak var view: LoadBattleViewInput!
    weak var coordinator: LoadBattleViewCoordinatorOutput!
    var interactor: LoadBattleInteractorInput!
    
    func viewDidLoad() {
        view.setupInitialState()
    }
    
    func onAcceptTap() {
        coordinator.onAccept?()
    }
}
