//
//  ElphTowerFL.swift
//  Defend It
//
//  Created by MacBook Pro on 19.03.22.
//

import SceneKit

class ElphTowerFL: Building {
    
    var id: UUID
    var type: BuildingTypes = .elphTower
    var level: BuildingLevels = .firstLevel
    var buildingNode: SCNNode
    var radius: CGFloat = 2.5
    var upgradeSelection: [BuildingIcons] = [.elphTowerSelectIcon]
    var upgrades: [BuiltTowers] = [.elphTowerSL]
    @Weak var enemiesInRadius: [AnyEnemy]
    var damage: CGFloat = 10
    var attackSpeed: CGFloat = 0.5
    var counter: Int = 0
    
    required init(_ buildingNode: SCNNode) {
        self.buildingNode = buildingNode
        id = UUID()
    }
}
