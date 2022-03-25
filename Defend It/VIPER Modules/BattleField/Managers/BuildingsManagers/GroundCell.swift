//
//  GroundCell.swift
//  Defend It
//
//  Created by MacBook Pro on 21.03.22.
//

import SceneKit

protocol GroundCell {
    var coordinate: (Int, Int)! {get set}
    var scnGroundNode: SCNNode! {get set}
    var scnBuildingNode: SCNNode? {get set}
}

struct GroundCellImpl: GroundCell {
    var coordinate: (Int, Int)!
    var scnGroundNode: SCNNode!
    var scnBuildingNode: SCNNode?
}
