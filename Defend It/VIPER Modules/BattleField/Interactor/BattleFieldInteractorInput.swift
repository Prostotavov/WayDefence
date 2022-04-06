// 
//  BattleFieldInteractorInput.swift
//  Defend It
//
//  Created by MacBook Pro on 16.03.22.
//

import Foundation
import SceneKit

protocol BattleFieldInteractorInput: AnyObject {
    func createGround() -> [[GroundCell]]
    func createFence() -> [FenceCell]
    func setupCamera() -> SCNNode
    func showTowerSelectionPanel(On position: SCNVector3) -> SCNNode
    func showTowerSelectionPanel(for buildingName: String) -> SCNNode
    
    func build(_ building: BuildingTypes, On position: SCNVector3) ->  SCNNode
    func runEnemies()
    func deleteBuilding(with name: String)
    
    func getEnemies() -> Set<AnyEnemy>
    
    func getBuildingName(with coordinate: (Int, Int)) -> String
}
