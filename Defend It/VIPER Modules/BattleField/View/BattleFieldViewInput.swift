// 
//  BattleFieldViewInput.swift
//  Defend It
//
//  Created by MacBook Pro on 16.03.22.
//

import Foundation
import SceneKit

protocol BattleFieldViewInput: AnyObject {
    func createGround(size: Int)
    func createFence(size: Int)
    func setupEnemy(size: Int)
    func setupCamera()
    func showTowerSelectionPanel(position: SCNVector3)
    func create(_ building: Buildings, On position: SCNVector3)
    func runToCastle(path: [SCNVector3])
}
