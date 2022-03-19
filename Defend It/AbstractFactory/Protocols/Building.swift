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
    var coordinate: (Int, Int) {get set}
    var scnNode: SCNNode {get set}
    
    init()
}
