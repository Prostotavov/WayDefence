//
//  BallistaFL.swift
//  Defend It
//
//  Created by MacBook Pro on 4.04.22.
//

import SceneKit

class BallistaFL: Building {
    
    var type: BuildingTypes = .ballista
    var level: BuildingLevels = .firstLevel
    var buildingNode: SCNNode
    var radius: CGFloat = 2.5
    var upgradeSelection: [BuildingIcons] = [.ballistaSelectIcon]
    var upgrades: [BuiltTowers] = [.ballistaSL]
    
    required init(_ buildingNode: SCNNode) {
        self.buildingNode = buildingNode
    }
}
