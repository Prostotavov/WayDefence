// 
//  QuestsPresenter.swift
//  Defend It
//
//  Created by Роман Сенкевич on 5.09.22.
//

import Foundation

class QuestsPresenter: QuestsViewOutput, QuestsInteractorOutput {

    weak var view: QuestsViewInput!
    weak var coordinator: QuestsViewCoordinatorOutput!
    var interactor: QuestsInteractorInput!
    
    func viewDidLoad() {
        view.setupInitialState()
    }
    
    func onBackPressed() {
        coordinator.onBack?()
    }
}
