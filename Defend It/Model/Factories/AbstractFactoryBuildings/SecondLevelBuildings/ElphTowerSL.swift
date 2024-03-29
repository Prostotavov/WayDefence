//
//  ElphTowerSL.swift
//  Defend It
//
//  Created by MacBook Pro on 19.03.22.
//

import SceneKit

class ElphTowerSL: Building {
    
    var id: UUID
    var type: BuildingTypes = .elphTower
    var level: BuildingLevels = .secondLevel
    var buildingNode: SCNNode
    var radius: CGFloat = 3.5
    var upgradeSelection: [BuildingIcons] = [.elphTowerSelectIcon]
    var upgrades: [BuiltTowers] = [.elphTowerTL]
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
