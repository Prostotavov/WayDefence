//
//  BallistaSL.swift
//  Defend It
//
//  Created by MacBook Pro on 4.04.22.
//

import SceneKit

class BallistaSL: Building {
    
    var type: BuildingTypes = .ballista
    var level: BuildingLevels = .secondLevel
    var buildingNode: SCNNode
    var radius: CGFloat = 2.5
    var upgradeSelection: [BuildingIcons] = [.ballistaSelectionIcon]
    
    required init(_ buildingNode: SCNNode) {
        self.buildingNode = buildingNode
    }
}
