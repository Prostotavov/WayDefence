//
//  WallSL.swift
//  Defend It
//
//  Created by MacBook Pro on 4.04.22.
//

import SceneKit

class WallSL: Building {
    
    var type: Buildings = .wall
    var level: BuildingLevels = .secondLevel
    var buildingNode: SCNNode
    var radius: CGFloat = 2.5
    
    required init(_ buildingNode: SCNNode) {
        self.buildingNode = buildingNode
    }
}
