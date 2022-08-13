//
//  FlowTabbarInteractor.swift
//  Defend It
//
//  Created by Роман Сенкевич on 6.08.22.
//

import Foundation

class FlowTabbarInteractor: FlowTabbarInteractorInput {
    
    weak var output: FlowTabbarInteractorOutput!
    
    weak var gameAccount : GameAccount?
    
    init() {
        gameAccount = UserImp.shared.gameAccount
    }
    
    func viewDidLoad() {
        displayValues()
    }
    
    func displayValues() {
        output.displayValue(of: .coins, to: gameAccount!.gameAccountValues!.get(.coins))
        output.displayValue(of: .gems, to: gameAccount!.gameAccountValues!.get(.gems))
        output.displayValue(of: .points, to: gameAccount!.gameAccountValues!.get(.points))
    }
}
