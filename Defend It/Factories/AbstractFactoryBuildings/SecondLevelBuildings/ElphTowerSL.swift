//
//  ElphTowerSL.swift
//  Defend It
//
//  Created by MacBook Pro on 19.03.22.
//

import SceneKit

class ElphTowerSL: Building {
    
    var type: BuildingTypes = .elphTower
    var level: BuildingLevels = .secondLevel
    var buildingNode: SCNNode
    var radius: CGFloat = 3.5
    var upgradeSelection: [BuildingIcons] = [.elphTowerSelectionIcon]
    var upgrades: [BuiltTowers] = [.elphTowerTL]
    
    required init(_ buildingNode: SCNNode) {
        self.buildingNode = buildingNode
    }
}
