// 
//  BattleFieldViewInput.swift
//  Defend It
//
//  Created by MacBook Pro on 16.03.22.
//

import Foundation
import SceneKit

protocol BattleFieldViewInput: AnyObject {
    
    func add(_ node: SCNNode)
    func removeNode(with name: String)
    func pressed(_ node: SCNNode)
}
