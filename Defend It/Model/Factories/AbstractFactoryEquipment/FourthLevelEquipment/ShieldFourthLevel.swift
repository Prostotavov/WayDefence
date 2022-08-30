//
//  ShieldFourthLevel.swift
//  Defend It
//
//  Created by Роман Сенкевич on 30.08.22.
//

import Foundation

struct ShieldFourthLevel: Equipment {
    
    var name: String
    var type: EquipmentTypes
    var level: EquipmentLevels
    var parameter: EquipmentParameter
    
    init() {
        name = "ShieldFourthLevel"
        type = .shield
        level = .fourthLevel
        parameter = EquipmentParameter(
            healthBonus: 400, damageBonus: 400, speedBonus: 4,
            radiusBonus: 4, cost: 80)
    }

}
