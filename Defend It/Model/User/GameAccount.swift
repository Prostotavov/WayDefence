//
//  GameAccount.swift
//  Defend It
//
//  Created by Роман Сенкевич on 5.08.22.
//

import Foundation

protocol GameAccount: AnyObject {
    var gameAccountValues: EconomicAccountValues? {get}
}

class GameAccountImp: GameAccount {
    var gameAccountValues: EconomicAccountValues?
    
    init() {
        gameAccountValues = EconomicAccountValuesImp()
    }
}

