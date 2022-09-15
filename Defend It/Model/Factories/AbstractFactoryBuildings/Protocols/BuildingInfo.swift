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
    var upgradeSelection: [BuildingIcons]
    var buildingNode: SCNNode
    
    internal init(type: BuildingTypes, level: BuildingLevels, upgrades: [BuiltTowers], upgradeSelection: [BuildingIcons], buildingNode: SCNNode) {
        self.type = type
        self.level = level
        self.upgrades = upgrades
        self.upgradeSelection = upgradeSelection
        self.buildingNode = buildingNode
    }
    
    internal init() {
        self.type = .elphTower
        self.level = .firstLevel
        self.upgrades = [.elphTowerSL]
        self.upgradeSelection = []
        self.buildingNode = SCNNode()
    }
}
