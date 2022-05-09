// 
//  BattleFieldInteractorOutput.swift
//  Defend It
//
//  Created by MacBook Pro on 16.03.22.
//

import Foundation
import SceneKit

protocol BattleFieldInteractorOutput: AnyObject {
    
    func add(_ node: SCNNode)
    func remove(_ node: SCNNode)
    func removeNode(with name: String)
    func setupPointOfView(from cameraNode: SCNNode)
    func setViewHorisontalOrientation()
    func setViewVerticalOrientation()
    func set(_ value: BattleValues, to number: Int)
}

