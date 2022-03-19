//
//  ElphTowerSL.swift
//  Defend It
//
//  Created by MacBook Pro on 19.03.22.
//

import UIKit
import SceneKit

struct ElphTowerSL: Building {
    
    var type: Buildings = .elphTower
    var coordinate: (Int, Int) = (0, 0)
    var scnNode: SCNNode = SCNNode()
    
    init() {
        
    }
}
