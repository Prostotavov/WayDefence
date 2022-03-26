//
//  BuildingsManager.swift
//  Defend It
//
//  Created by MacBook Pro on 21.03.22.
//

import SceneKit

protocol BuildingsManager {
    func showTowerSelectionPanel(On position: SCNVector3) -> SCNNode
    func build(_ building: Buildings, On position: SCNVector3) ->  SCNNode
    func deleteBuilding(with name: String)
}

class BuildingsManagerImpl: BuildingsManager {
    
    var towerBuilder = TowerBuilderImpl()
    var towerSelectionPanel: TowerSelectionPanel!
    var battleFieldSize: Int!
    
    init(_ battleFieldSize: Int) {
        self.battleFieldSize = battleFieldSize
        setupBuildingSelectionPanel()
        
    }
    
    func setupBuildingSelectionPanel() {
        var selectionItems: [SCNNode] = []
        selectionItems.append(ElphTowerFactory.defaultFactory.createFirstLevelBuildings().buildingNode.clone())
        towerSelectionPanel = TowerSelectionPanelImpl(selectionItems: selectionItems)
    }
    
    func showTowerSelectionPanel(On position: SCNVector3) -> SCNNode {
        towerSelectionPanel.show(on: position)
    }
    
    func build(_ building: Buildings, On position: SCNVector3) ->  SCNNode {
        towerBuilder.build(building, On: position)
    }
    
    func deleteBuilding(with name: String) {
        towerBuilder.deleteBuilding(with: name)
    }
}
