// 
//  BattleFieldViewInput.swift
//  Defend It
//
//  Created by MacBook Pro on 16.03.22.
//

import Foundation
import SceneKit

protocol BattleFieldViewInput: AnyObject {
    
    /// funcs for add and remove nodes on the scene
    func addNodeToScene(_ node: SCNNode)
    func removeNodeFromScene(_ node: SCNNode)
    func removeNodeFromScene(with name: String)
    
    /// funcs for setup camera
    func setupPointOfView(from cameraNode: SCNNode)
    func setViewHorisontalOrientation()
    func setViewVerticalOrientation()
    
    /// funcs for display battle values on the TopBarView
    func displayValue(of valueType: BattleValues, to number: Int)
}
