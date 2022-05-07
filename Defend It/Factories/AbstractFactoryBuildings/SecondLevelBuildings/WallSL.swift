//
//  WallSL.swift
//  Defend It
//
//  Created by MacBook Pro on 4.04.22.
//

import SceneKit

class WallSL: Building {
    
    var id: UUID
    var type: BuildingTypes = .wall
    var level: BuildingLevels = .secondLevel
    var buildingNode: SCNNode
    var radius: CGFloat = 2.5
    var upgradeSelection: [BuildingIcons] = [.wallSelectIcon]
    var upgrades: [BuiltTowers] = [.wallTL]
    @Weak var enemiesInRadius: [AnyEnemy]
    
    required init(_ buildingNode: SCNNode) {
        self.buildingNode = buildingNode
        id = UUID()
    }
}
