//
//  ElphTowerTL.swift
//  Defend It
//
//  Created by MacBook Pro on 4.04.22.
//

import SceneKit

class ElphTowerTL: Building {
    
    var id: UUID
    var type: BuildingTypes = .elphTower
    var level: BuildingLevels = .thirdLevel
    var buildingNode: SCNNode
    var radius: CGFloat = 4.5
    var upgradeSelection: [BuildingIcons] = [.elphTowerSelectIcon]
    var upgrades: [BuiltTowers] = []
    @Weak var enemiesInRadius: [AnyEnemy]
    var damage: CGFloat = 50
    var attackSpeed: CGFloat = 0.2
    var counter: Int = 0
    var buildingCost: Int = 45
    var saleCost: Int = 22
    
    required init(_ buildingNode: SCNNode) {
        self.buildingNode = buildingNode
        id = UUID()
    }
}
