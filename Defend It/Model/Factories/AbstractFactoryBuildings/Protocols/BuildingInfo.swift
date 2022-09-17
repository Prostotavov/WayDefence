//
//  BuildingInfo.swift
//  Defend It
//
//  Created by Роман Сенкевич on 13.09.22.
//

import SceneKit

struct BuildingInfo {
    
    var type: BuildingTypes
    var level: BuildingLevels
    var upgrades: [BuiltTowers]
    
    internal init(type: BuildingTypes, level: BuildingLevels, upgrades: [BuiltTowers]) {
        self.type = type
        self.level = level
        self.upgrades = upgrades
    }
    
    internal init() {
        self.type = .elphTower
        self.level = .firstLevel
        self.upgrades = [.elphTowerSL]
    }
}
