// 
//  BattleFieldViewInput.swift
//  Defend It
//
//  Created by MacBook Pro on 16.03.22.
//

import Foundation
import SceneKit

protocol BattleFieldViewInput: AnyObject {
    func createGround()
    func createFence()
    func setupEnemy()
    func setupCamera()
    func showTowerSelectionPanel(On position: SCNVector3)
    func build(_ building: Buildings, On position: SCNVector3)
    func run()
}
