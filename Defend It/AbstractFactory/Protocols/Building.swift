//
//  Building.swift
//  Defend It
//
//  Created by MacBook Pro on 19.03.22.
//

import UIKit
import SceneKit

protocol Building {
    
    var type: Buildings {get set}
    var level: Levels {get set}
    var buildingNode: SCNNode {get set}
    
    init(_ buildingNode: SCNNode)
}
