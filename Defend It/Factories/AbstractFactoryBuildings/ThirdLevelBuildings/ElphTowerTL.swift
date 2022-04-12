//
//  ElphTowerTL.swift
//  Defend It
//
//  Created by MacBook Pro on 4.04.22.
//

import SceneKit

class ElphTowerTL: Building {
    
    var type: BuildingTypes = .elphTower
    var level: BuildingLevels = .thirdLevel
    var buildingNode: SCNNode
    var radius: CGFloat = 4.5
    var upgradeSelection: [BuildingIcons] = [.elphTowerSelectionIcon]
    var upgrades: [BuiltTowers] = []
    
    required init(_ buildingNode: SCNNode) {
        self.buildingNode = buildingNode
    }
}
