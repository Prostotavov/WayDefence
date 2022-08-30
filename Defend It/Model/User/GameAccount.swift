//
//  GameAccount.swift
//  Defend It
//
//  Created by Роман Сенкевич on 5.08.22.
//

import Foundation

protocol GameAccount: AnyObject {
    var gameAccountValues: EconomicAccountValues? {get}
    var equipmentBag: EquipmentBag? {get set}
}

class GameAccountImp: GameAccount {
    var gameAccountValues: EconomicAccountValues?
    var equipmentBag: EquipmentBag?
    
    init() {
        gameAccountValues = EconomicAccountValuesImp()
        equipmentBag = EquipmentBagImp()
    }
}

