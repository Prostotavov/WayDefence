// 
//  BagPresenter.swift
//  Defend It
//
//  Created by Роман Сенкевич on 30.08.22.
//

import Foundation

class BagPresenter: BagViewOutput, BagInteractorOutput {

    weak var view: BagViewInput!
    weak var coordinator: BagViewCoordinatorOutput!
    var interactor: BagInteractorInput!
    
    func viewDidLoad() {
        view.setupInitialState()
    }
    
    func onBackPressed() {
        coordinator.onBack?()
    }
}
