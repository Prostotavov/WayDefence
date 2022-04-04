//
//  BallistaFL.swift
//  Defend It
//
//  Created by MacBook Pro on 4.04.22.
//

import SceneKit

class BallistaFL: Building {
    
    var type: Buildings = .ballista
    var level: BuildingLevels = .firstLevel
    var buildingNode: SCNNode
    var radius: CGFloat = 2.5
    
    required init(_ buildingNode: SCNNode) {
        self.buildingNode = buildingNode
    }
}
