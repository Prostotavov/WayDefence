//
//  MagicTowerSL.swift
//  Defend It
//
//  Created by MacBook Pro on 19.03.22.
//

import SceneKit

class MagicTowerSL: Building {
    
    var id: UUID
    var type: BuildingTypes = .magicTower
    var level: BuildingLevels = .secondLevel
    var buildingNode: SCNNode
    var radius: CGFloat = 4
    var upgradeSelection: [BuildingIcons] = [.magicTowerSelectIcon]
    var upgrades: [BuiltTowers] = [.magicTowerTL]
    @Weak var enemiesInRadius: [AnyEnemy]
    var damage: CGFloat = 35
    var attackSpeed: CGFloat = 0.3
    var counter: Int = 0
    var buildingCost: Int = 35
    var saleCost: Int = 17
    
    required init(_ buildingNode: SCNNode) {
        self.buildingNode = buildingNode
        id = UUID()
    }
}
