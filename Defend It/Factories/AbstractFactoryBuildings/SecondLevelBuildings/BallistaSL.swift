//
//  BallistaSL.swift
//  Defend It
//
//  Created by MacBook Pro on 4.04.22.
//

import SceneKit

class BallistaSL: Building {
    
    var id: UUID
    var type: BuildingTypes = .ballista
    var level: BuildingLevels = .secondLevel
    var buildingNode: SCNNode
    var radius: CGFloat = 2.5
    var upgradeSelection: [BuildingIcons] = [.ballistaSelectIcon]
    var upgrades: [BuiltTowers] = [.ballistaTL]
    @Weak var enemiesInRadius: [AnyEnemy]
    var damage: CGFloat = 35
    var attackSpeed: CGFloat = 0.3
    var counter: Int = 0
    
    required init(_ buildingNode: SCNNode) {
        self.buildingNode = buildingNode
        id = UUID()
    }
}
