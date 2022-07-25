// 
//  BattleFieldInteractorOutput.swift
//  Defend It
//
//  Created by MacBook Pro on 16.03.22.
//

import Foundation
import SceneKit

protocol BattleFieldInteractorOutput: AnyObject {
    
    // funcs for add and remove nodes from the scene
    func addNodeToScene(_ node: SCNNode)
    func removeNodeFromScene(_ node: SCNNode)
    func removeNodeFromScene(with name: String)

    // set the battle Values
    func displayValue(of valueType: BattleValueTypes, to number: Int)
    
    // funcs for set the camera
    func setupPointOfView(from cameraNode: SCNNode)
    func setViewHorisontalOrientation()
    func setViewVerticalOrientation()
}

