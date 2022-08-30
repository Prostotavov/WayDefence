//
//  HammerFourthLevel.swift
//  Defend It
//
//  Created by Роман Сенкевич on 30.08.22.
//

import Foundation

struct HammerFourthLevel: Equipment {
    
    var name: String
    var type: EquipmentTypes
    var level: EquipmentLevels
    var parameter: EquipmentParameter
    
    init() {
        name = "HammerFourthLevel"
        type = .hammer
        level = .fourthLevel
        parameter = EquipmentParameter(
            healthBonus: 400, damageBonus: 400, speedBonus: 4,
            radiusBonus: 4, cost: 80)
    }

}
