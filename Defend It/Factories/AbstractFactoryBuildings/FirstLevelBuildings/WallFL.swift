//
//  WallFL.swift
//  Defend It
//
//  Created by MacBook Pro on 4.04.22.
//

import SceneKit

class WallFL: Building {
    
    var type: BuildingTypes = .wall
    var level: BuildingLevels = .firstLevel
    var buildingNode: SCNNode
    var radius: CGFloat = 2.5
    var upgradeSelection: [BuildingIcons] = [.wallSelectionIcon]
    var upgrades: [BuiltTowers] = [.wallSL]
    
    required init(_ buildingNode: SCNNode) {
        self.buildingNode = buildingNode
    }
}
