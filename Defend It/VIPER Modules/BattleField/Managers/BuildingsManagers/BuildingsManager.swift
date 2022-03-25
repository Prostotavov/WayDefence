//
//  BuildingsManager.swift
//  Defend It
//
//  Created by MacBook Pro on 21.03.22.
//

import SceneKit

protocol BuildingsManager {
    mutating func createGround() -> [[GroundCell]]
    func showTowerSelectionPanel(On position: SCNVector3) -> SCNNode
    mutating func build(_ building: Buildings, On position: SCNVector3) ->  SCNNode
    mutating func deleteBuilding(with name: String)
}

struct BuildingsManagerImpl: BuildingsManager {
    
    var ground: Ground = GroundImpl()
    var towerSelectionPanel: TowerSelectionPanel!
    var battleFieldSize: Int!
    
    init(_ battleFieldSize: Int) {
        self.battleFieldSize = battleFieldSize
        setupBuildingSelectionPanel()
        
    }
    
    mutating func setupBuildingSelectionPanel() {
        var selectionItems: [SCNNode] = []
        selectionItems.append(ground.get(.elphTower))
        towerSelectionPanel = TowerSelectionPanelImpl(selectionItems: selectionItems)
    }
    
    func showTowerSelectionPanel(On position: SCNVector3) -> SCNNode {
        towerSelectionPanel.show(on: position)
    }
    
    mutating func createGround() -> [[GroundCell]] {
        ground.createGround(size: battleFieldSize)
    }
    
    mutating func build(_ building: Buildings, On position: SCNVector3) ->  SCNNode {
        var tower = ground.build(building, On: position)
        return tower
    }
    
    mutating func deleteBuilding(with name: String) {
        ground.deleteBuilding(with: name)
    }
}
