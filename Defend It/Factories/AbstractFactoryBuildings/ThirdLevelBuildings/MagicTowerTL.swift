//
//  MagicTowerTL.swift
//  Defend It
//
//  Created by MacBook Pro on 4.04.22.
//

import SceneKit

class MagicTowerTL: Building {
    
    var type: BuildingTypes = .magicTower
    var level: BuildingLevels = .thirdLevel
    var buildingNode: SCNNode
    var radius: CGFloat = 5
    var upgradeSelection: [BuildingIcons] = [.magicTowerSelectIcon]
    var upgrades: [BuiltTowers] = []
    
    required init(_ buildingNode: SCNNode) {
        self.buildingNode = buildingNode
    }
}
