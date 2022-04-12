//
//  BallistaTL.swift
//  Defend It
//
//  Created by MacBook Pro on 4.04.22.
//

import SceneKit

class BallistaTL: Building {
    
    var type: BuildingTypes = .ballista
    var level: BuildingLevels = .thirdLevel
    var buildingNode: SCNNode
    var radius: CGFloat = 2.5
    var upgradeSelection: [BuildingIcons] = [.ballistaSelectionIcon]
    var upgrades: [BuiltTowers] = []
    
    required init(_ buildingNode: SCNNode) {
        self.buildingNode = buildingNode
    }
}
