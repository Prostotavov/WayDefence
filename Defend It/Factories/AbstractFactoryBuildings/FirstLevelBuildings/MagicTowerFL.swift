//
//  MagicTowerFL.swift
//  Defend It
//
//  Created by MacBook Pro on 19.03.22.
//

import UIKit
import SceneKit

class MagicTowerFL: Building {
    
    var type: Buildings = .magicTower
    var level: BuildingLevels = .firstLevel
    var buildingNode: SCNNode
    
    required init(_ buildingNode: SCNNode) {
        self.buildingNode = buildingNode
    }
}
