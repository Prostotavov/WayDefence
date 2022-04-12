//
//  WallTL.swift
//  Defend It
//
//  Created by MacBook Pro on 4.04.22.
//

import SceneKit

class WallTL: Building {
    
    var type: BuildingTypes = .wall
    var level: BuildingLevels = .thirdLevel
    var buildingNode: SCNNode
    var radius: CGFloat = 2.5
    var upgradeSelection: [BuildingIcons] = [.wallSelectionIcon]
    var upgrades: [BuiltTowers] = []
    
    required init(_ buildingNode: SCNNode) {
        self.buildingNode = buildingNode
    }
}
