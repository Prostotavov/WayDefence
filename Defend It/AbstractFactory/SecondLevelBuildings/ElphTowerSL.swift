//
//  ElphTowerSL.swift
//  Defend It
//
//  Created by MacBook Pro on 19.03.22.
//

import UIKit
import SceneKit

class ElphTowerSL: Building {
    
    var type: Buildings = .elphTower
    var level: Levels = .secondLevel
    var buildingNode: SCNNode
    
    required init(_ buildingNode: SCNNode) {
        self.buildingNode = buildingNode
    }
}
