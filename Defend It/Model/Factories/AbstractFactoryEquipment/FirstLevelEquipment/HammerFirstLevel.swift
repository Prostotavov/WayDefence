//
//  HammerFirstLevel.swift
//  Defend It
//
//  Created by Роман Сенкевич on 30.08.22.
//

import Foundation

struct HammerFirstLevel: Equipment {
    
    var name: String
    var type: EquipmentTypes
    var level: EquipmentLevels
    var parameter: EquipmentParameter
    
    init() {
        name = "HammerFirstLevel"
        type = .hammer
        level = .firstLevel
        parameter = EquipmentParameter(
            healthBonus: 100, damageBonus: 100, speedBonus: 1,
            radiusBonus: 1, cost: 20)
    }

}
