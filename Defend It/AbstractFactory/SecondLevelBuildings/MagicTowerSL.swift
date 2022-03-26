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
    var level: Levels = .secondLevel
    var buildingNode: SCNNode
    
    required init(_ buildingNode: SCNNode) {
        self.buildingNode = buildingNode
    }
}
