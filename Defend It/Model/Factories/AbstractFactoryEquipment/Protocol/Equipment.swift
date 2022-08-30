//
//  Equipment.swift
//  Defend It
//
//  Created by Роман Сенкевич on 30.08.22.
//

import Foundation

enum EquipmentTypes: String {
    case arch
    case hammer
    case blade
    case shield
}

enum EquipmentLevels: Int {
    case firstLevel = 1
    case secondLevel = 2
    case thirdLevel = 3
    case fourthLevel = 4
    
}

struct EquipmentParameter {
    var healthBonus: Int?
    var damageBonus: Int?
    var speedBonus: Int?
    var radiusBonus: Int?
    var cost: Int?
}

protocol Equipment {
    
    var name: String {get set}
    var type: EquipmentTypes {get set}
    var level: EquipmentLevels {get set}
    var parameter: EquipmentParameter {get set}
}
