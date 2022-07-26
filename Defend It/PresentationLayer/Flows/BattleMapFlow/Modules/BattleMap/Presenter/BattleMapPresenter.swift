// 
//  BattleMapPresenter.swift
//  Defend It
//
//  Created by Роман Сенкевич on 26.07.22.
//

import Foundation

class BattleMapPresenter: ___VARIABLE_productName___ViewOutput, ___VARIABLE_productName___InteractorOutput {

    weak var view: ___VARIABLE_productName___ViewInput!
    weak var coordinator: ___VARIABLE_productName___ViewCoordinatorOutput!
    var interactor: ___VARIABLE_productName___InteractorInput!
    
    func viewDidLoad() {
        view.setupInitialState()
    }
    
    func onAcceptTap() {
        coordinator.onAccept?()
    }
}
