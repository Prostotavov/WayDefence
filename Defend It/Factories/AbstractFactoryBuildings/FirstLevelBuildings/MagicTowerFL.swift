//
//  MagicTowerFL.swift
//  Defend It
//
//  Created by MacBook Pro on 19.03.22.
//

import SceneKit

class MagicTowerFL: Building {
    
    var id: UUID
    var type: BuildingTypes = .magicTower
    var level: BuildingLevels = .firstLevel
    var buildingNode: SCNNode
    var radius: CGFloat = 3
    var upgradeSelection: [BuildingIcons] = [.magicTowerSelectIcon]
    var upgrades: [BuiltTowers] = [.magicTowerSL]
    @Weak var enemiesInRadius: [AnyEnemy]
    
    required init(_ buildingNode: SCNNode) {
        self.buildingNode = buildingNode
        id = UUID()
    }
}
