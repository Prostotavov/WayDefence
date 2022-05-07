//
//  Building.swift
//  Defend It
//
//  Created by MacBook Pro on 19.03.22.
//

import SceneKit

protocol Building {
    
    var id: UUID {get set}
    var type: BuildingTypes {get set}
    var level: BuildingLevels {get set}
    var radius: CGFloat {get set}
    var buildingNode: SCNNode {get set}
    var upgradeSelection: [BuildingIcons] {get set}
    var upgrades: [BuiltTowers] {get set}
    var enemiesInRadius: [AnyEnemy] {get set}
    
    init(_ buildingNode: SCNNode)
}
