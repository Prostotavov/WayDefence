//
//  BuildingAppearance.swift
//  Defend It
//
//  Created by Роман Сенкевич on 15.09.22.
//

import SceneKit

struct BuildingAppearance {

    var icons: [BuildingIcons]
    var buildingNode: SCNNode
    var size: (Int, Int)
    
    internal init(icons: [BuildingIcons], buildingNode: SCNNode, size: (Int, Int)) {
        self.icons = icons
        self.buildingNode = buildingNode
        self.size = size
    }
    
    internal init() {
        self.icons = []
        self.buildingNode = SCNNode()
        self.size = (0, 0)
    }
}
