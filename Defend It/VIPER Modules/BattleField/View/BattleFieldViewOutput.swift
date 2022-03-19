// 
//  BattleFieldViewOutput.swift
//  Defend It
//
//  Created by MacBook Pro on 16.03.22.
//

import Foundation
import SceneKit

protocol BattleFieldViewOutput: AnyObject {
    func createGround(size: Int) -> [[GroundCell]]
    func createFence(size: Int) -> [FenceCell]
    func getEnemy(size: Int) -> Enemy
    func setupCamera() -> SCNNode
    func getTowerSelectionPanel(position: SCNVector3) -> SCNNode
    
}
