//
//  HammerThirdLevel.swift
//  Defend It
//
//  Created by Роман Сенкевич on 30.08.22.
//

import Foundation

struct HammerThirdLevel: Equipment {
    
    var name: String
    var type: EquipmentTypes
    var level: EquipmentLevels
    var parameter: EquipmentParameter
    
    init() {
        name = "HammerThirdLevel"
        type = .hammer
        level = .thirdLevel
        parameter = EquipmentParameter(
            healthBonus: 300, damageBonus: 300, speedBonus: 3,
            radiusBonus: 3, cost: 60)
    }

}
