//
//  BladeFirstLevel.swift
//  Defend It
//
//  Created by Роман Сенкевич on 30.08.22.
//

import Foundation

struct BladeFirstLevel: Equipment {
    
    var name: String
    var imageName: EquipmentImageNames
    var type: EquipmentTypes
    var level: EquipmentLevels
    var parameter: EquipmentParameter
    
    init() {
        name = "BladeFirstLevel"
        imageName = .blade
        type = .blade
        level = .firstLevel
        parameter = EquipmentParameter(
            healthBonus: 100, damageBonus: 100, speedBonus: 1,
            radiusBonus: 1, cost: 20)
    }

}
