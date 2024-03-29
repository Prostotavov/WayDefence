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
    var damage: CGFloat {get set}
    var attackSpeed: CGFloat {get set}
    var counter: Int {get set}
    var buildingCost: Int {get set}
    var saleCost: Int {get set}
    
    init(_ buildingNode: SCNNode)
}
