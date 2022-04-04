//
//  ElphTowerFL.swift
//  Defend It
//
//  Created by MacBook Pro on 19.03.22.
//

import UIKit
import SceneKit

class ElphTowerFL: Building {
    
    var type: Buildings = .elphTower
    var level: BuildingLevels = .firstLevel
    var buildingNode: SCNNode
    var radius: CGFloat = 2.5
    
    required init(_ buildingNode: SCNNode) {
        self.buildingNode = buildingNode
    }
}
