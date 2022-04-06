//
//  MagicTowerFL.swift
//  Defend It
//
//  Created by MacBook Pro on 19.03.22.
//

import SceneKit

class MagicTowerFL: Building {
    
    var type: BuildingTypes = .magicTower
    var level: BuildingLevels = .firstLevel
    var buildingNode: SCNNode
    var radius: CGFloat = 3
    var upgradeSelection: [BuildingIcons] = [.magicTowerSelectionIcon]
    
    required init(_ buildingNode: SCNNode) {
        self.buildingNode = buildingNode
    }
}
