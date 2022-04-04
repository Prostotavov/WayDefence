//
//  MagicTowerSL.swift
//  Defend It
//
//  Created by MacBook Pro on 19.03.22.
//

import UIKit
import SceneKit

class MagicTowerSL: Building {
    
    var type: Buildings = .magicTower
    var level: BuildingLevels = .secondLevel
    var buildingNode: SCNNode
    var radius: CGFloat = 4
    
    required init(_ buildingNode: SCNNode) {
        self.buildingNode = buildingNode
    }
}
