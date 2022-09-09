// 
//  AchievePresenter.swift
//  Defend It
//
//  Created by Роман Сенкевич on 9.09.22.
//

import Foundation

class AchievePresenter: AchieveViewOutput, AchieveInteractorOutput {

    weak var view: AchieveViewInput!
    weak var coordinator: AchieveViewCoordinatorOutput!
    var interactor: AchieveInteractorInput!
    
    func viewDidLoad() {
        view.setupInitialState()
    }
    
    func onBackPressed() {
        coordinator.onBack?()
    }
}
