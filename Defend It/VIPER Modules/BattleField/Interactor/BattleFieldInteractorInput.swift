// 
//  BattleFieldInteractorInput.swift
//  Defend It
//
//  Created by MacBook Pro on 16.03.22.
//

import Foundation
import SceneKit

protocol BattleFieldInteractorInput: AnyObject {
    func createGround(size: Int) -> [[GroundCell]]
    func createFence(size: Int) -> [FenceCell]
    func getEnemy(size: Int) -> Enemy
    func setupCamera() -> SCNNode
    func getTowerSelectionPanel(position: SCNVector3) -> SCNNode
    func create(_ building: Buildings, On position: SCNVector3) ->  SCNNode
}
