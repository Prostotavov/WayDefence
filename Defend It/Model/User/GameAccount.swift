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
    var dailyQuests: DailyQuests? {get set}
}

class GameAccountImp: GameAccount {
    var gameAccountValues: EconomicAccountValues?
    var equipmentBag: EquipmentBag?
    var dailyQuests: DailyQuests?
    
    init() {
        gameAccountValues = EconomicAccountValuesImp()
        equipmentBag = EquipmentBagImp()
        dailyQuests = DailyQuestsImp()
    }
}

