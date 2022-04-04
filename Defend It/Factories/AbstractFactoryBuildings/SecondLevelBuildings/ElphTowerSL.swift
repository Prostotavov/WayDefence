//
//  ElphTowerSL.swift
//  Defend It
//
//  Created by MacBook Pro on 19.03.22.
//

import SceneKit

class ElphTowerSL: Building {
    
    var type: Buildings = .elphTower
    var level: BuildingLevels = .secondLevel
    var buildingNode: SCNNode
    var radius: CGFloat = 3.5
    
    required init(_ buildingNode: SCNNode) {
        self.buildingNode = buildingNode
    }
}
