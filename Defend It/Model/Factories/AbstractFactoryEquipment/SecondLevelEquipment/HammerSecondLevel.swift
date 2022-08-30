//
//  HammerSecondLevel.swift
//  Defend It
//
//  Created by Роман Сенкевич on 30.08.22.
//

import Foundation

struct HammerSecondLevel: Equipment {
    
    var name: String
    var type: EquipmentTypes
    var level: EquipmentLevels
    var parameter: EquipmentParameter
    
    init() {
        name = "HammerSecondLevel"
        type = .hammer
        level = .secondLevel
        parameter = EquipmentParameter(
            healthBonus: 200, damageBonus: 200, speedBonus: 2,
            radiusBonus: 2, cost: 40)
    }

}
