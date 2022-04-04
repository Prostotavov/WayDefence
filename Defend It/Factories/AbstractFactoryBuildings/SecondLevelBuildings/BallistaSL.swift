//
//  BallistaSL.swift
//  Defend It
//
//  Created by MacBook Pro on 4.04.22.
//

import SceneKit

class BallistaSL: Building {
    
    var type: Buildings = .ballista
    var level: BuildingLevels = .secondLevel
    var buildingNode: SCNNode
    var radius: CGFloat = 2.5
    
    required init(_ buildingNode: SCNNode) {
        self.buildingNode = buildingNode
    }
}
