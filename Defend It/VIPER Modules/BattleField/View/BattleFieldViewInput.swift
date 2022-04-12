// 
//  BattleFieldViewInput.swift
//  Defend It
//
//  Created by MacBook Pro on 16.03.22.
//

import Foundation
import SceneKit

protocol BattleFieldViewInput: AnyObject {
    func setupGround()
    func setupCamera()
    func setupEnemies()
    
    func showTowerSelectionPanel(on position: SCNVector3)
    func showTowerSelectionPanel(for buildingName: String)
    
    func enemyPressed()
    func floorPressed()
    func sellIconPressed(with coordinate: (Int, Int))
    func groundSquarePressed(on position: SCNVector3)
    func buildingIconPressed(with name: String, and position: SCNVector3)
    func builtTowerPressed(with name: String)
    
    
}
