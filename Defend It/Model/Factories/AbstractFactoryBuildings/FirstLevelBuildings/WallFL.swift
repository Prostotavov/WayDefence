//
//  WallFL.swift
//  Defend It
//
//  Created by MacBook Pro on 4.04.22.
//

import SceneKit

class WallFL: Building {
    
    var id: UUID
    var type: BuildingTypes = .wall
    var level: BuildingLevels = .firstLevel
    var buildingNode: SCNNode
    var radius: CGFloat = 2.5
    var upgradeSelection: [BuildingIcons] = [.wallSelectIcon]
    var upgrades: [BuiltTowers] = [.wallSL]
    @Weak var enemiesInRadius: [AnyEnemy]
    var damage: CGFloat = 0
    var attackSpeed: CGFloat = 0.05
    var counter: Int = 0
    var buildingCost: Int = 30
    var saleCost: Int = 15
    
    required init(_ buildingNode: SCNNode) {
        self.buildingNode = buildingNode
        id = UUID()
    }
}
