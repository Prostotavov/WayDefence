//
//  BuildingsManager.swift
//  Defend It
//
//  Created by MacBook Pro on 21.03.22.
//

import SceneKit

protocol BuildingsManager {
    func createGround() -> [[GroundCell]]
    func showTowerSelectionPanel(On position: SCNVector3) -> SCNNode
    func build(_ building: Buildings, On position: SCNVector3) ->  SCNNode
    func deleteBuilding(with name: String)
}

class BuildingsManagerImpl: BuildingsManager {
    
    var ground: Ground = GroundImpl()
    var towerSelectionPanel: TowerSelectionPanel!
    var battleFieldSize: Int!
    
    init(_ battleFieldSize: Int) {
        self.battleFieldSize = battleFieldSize
        setupBuildingSelectionPanel()
        
    }
    
    func setupBuildingSelectionPanel() {
        var selectionItems: [SCNNode] = []
        selectionItems.append(ground.get(.elphTower))
        towerSelectionPanel = TowerSelectionPanelImpl(selectionItems: selectionItems)
    }
    
    func showTowerSelectionPanel(On position: SCNVector3) -> SCNNode {
        towerSelectionPanel.show(on: position)
    }
    
    func createGround() -> [[GroundCell]] {
        ground.createGround(size: battleFieldSize)
    }
    
    func build(_ building: Buildings, On position: SCNVector3) ->  SCNNode {
        var tower = ground.build(building, On: position)
        return tower
    }
    
    func deleteBuilding(with name: String) {
        ground.deleteBuilding(with: name)
    }
}
