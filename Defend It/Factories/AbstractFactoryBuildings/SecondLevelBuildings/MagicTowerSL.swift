//
//  MagicTowerSL.swift
//  Defend It
//
//  Created by MacBook Pro on 19.03.22.
//

import SceneKit

class MagicTowerSL: Building {
    
    var type: BuildingTypes = .magicTower
    var level: BuildingLevels = .secondLevel
    var buildingNode: SCNNode
    var radius: CGFloat = 4
    var upgradeSelection: [BuildingIcons] = [.magicTowerSelectionIcon]
    
    required init(_ buildingNode: SCNNode) {
        self.buildingNode = buildingNode
    }
}
