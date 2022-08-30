//
//  ArchFirstLevel.swift
//  Defend It
//
//  Created by Роман Сенкевич on 30.08.22.
//

import Foundation

struct ArchFirstLevel: Equipment {
    
    var name: String
    var type: EquipmentTypes
    var level: EquipmentLevels
    var parameter: EquipmentParameter
    
    init() {
        name = "ArchFirstLevel"
        type = .arch
        level = .firstLevel
        parameter = EquipmentParameter(
            healthBonus: 100, damageBonus: 100, speedBonus: 1,
            radiusBonus: 1, cost: 20)
    }

}
