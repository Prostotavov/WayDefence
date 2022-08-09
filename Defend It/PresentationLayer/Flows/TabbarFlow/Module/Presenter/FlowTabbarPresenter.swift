//
//  FlowTabbarPresenter.swift
//  Defend It
//
//  Created by Роман Сенкевич on 6.08.22.
//

import Foundation

class FlowTabbarPresenter: FlowTabbarViewOutput, FlowTabbarInteractorOutput {

    weak var view: FlowTabbarViewInput!
    weak var coordinator: FlowTabbarCoordinatorOutput!
    var interactor: FlowTabbarInteractorInput!
    
    func displayValue(of valueType: GameAccountValueTypes, to value: Int) {
        view.displayValue(of: valueType, to: value)
    }
    
    func viewDidLoad() {
        interactor.viewDidLoad()
    }
}
