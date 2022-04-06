//
//  Building.swift
//  Defend It
//
//  Created by MacBook Pro on 19.03.22.
//

import SceneKit

protocol Building {
    
    var type: BuildingTypes {get set}
    var level: BuildingLevels {get set}
    var radius: CGFloat {get set}
    var buildingNode: SCNNode {get set}
    var upgradeSelection: [BuildingIcons] {get set}
    
    init(_ buildingNode: SCNNode)
}
