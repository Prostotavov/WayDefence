//
//  BuildingsManager.swift
//  Defend It
//
//  Created by MacBook Pro on 21.03.22.
//

import SceneKit

protocol BuildingsManager {
    func showTowerSelectionPanel(On position: SCNVector3) -> SCNNode
    func showTowerSelectionPanel(for buildingName: String) -> SCNNode
    func build(_ building: BuildingTypes, On position: SCNVector3) ->  SCNNode
    func upgradeBuilding(with coordinate: (Int, Int)) -> SCNNode
    func deleteBuilding(with name: String)
    func getBuildingName(with coordinate: (Int, Int)) -> String
    func isExistBuiling(on coordinate: (Int, Int)) -> Bool
}

class BuildingsManagerImpl: BuildingsManager {
    
    var towerBuilder = TowerBuilderImpl()
    var towerSelectionPanel: TowerSelectionPanel!
    var battleFieldSize: Int!
    var buildings: [[Building?]]!
    
    init(_ battleFieldSize: Int) {
        self.battleFieldSize = battleFieldSize
        createBuildingsArray()
        setupBuildingSelectionPanel()
    }
    
    private func createBuildingsArray() {
        let row: [Building?] = Array(repeating: nil, count: battleFieldSize)
        buildings = Array(repeating: row, count: battleFieldSize)
    }
    
    private func setupBuildingSelectionPanel() {
        towerSelectionPanel = TowerSelectionPanelImpl()
    }
    
    func showTowerSelectionPanel(On position: SCNVector3) -> SCNNode {
        towerSelectionPanel.show(on: position)
    }
    
    func showTowerSelectionPanel(for buildingName: String) -> SCNNode {
        let coordinate = Converter.toCoordinate(from: buildingName)
        return towerSelectionPanel.show(for: buildings[coordinate.0][coordinate.1]!)
    }
    
    func build(_ building: BuildingTypes, On position: SCNVector3) ->  SCNNode {
        let coordinate = Converter.toCoordinate(from: position)
        let building = towerBuilder.build(building, On: position)
        buildings[coordinate.0][coordinate.1] = building
        return building.buildingNode
    }
    
    func upgradeBuilding(with coordinate: (Int, Int)) -> SCNNode {
        let building = buildings[coordinate.0][coordinate.1]!
        let type = building.type
        let level = getUpLevel(for: building.level)
        let upgradeBuilding = AbstactFactoryBuildingsImpl.defaultFactory.create(type, with: level)
        upgradeBuilding.buildingNode.position = buildings[coordinate.0][coordinate.1]!.buildingNode.position
        upgradeBuilding.buildingNode.name! += "(\(coordinate.0),\(coordinate.1))"
        buildings[coordinate.0][coordinate.1] = upgradeBuilding
        return upgradeBuilding.buildingNode
    }
    
    private func getUpLevel(for level: BuildingLevels) -> BuildingLevels {
        switch level {
        case .firstLevel:
            return .secondLevel
        case .secondLevel:
            return .thirdLevel
        case .thirdLevel:
            return .thirdLevel
        }
    }
    
    func deleteBuilding(with name: String) {
        let coordinate = Converter.toCoordinate(from: name)
        buildings[coordinate.0][coordinate.1] = nil
    }
    
    func getBuildingName(with coordinate: (Int, Int)) -> String {
        buildings[coordinate.0][coordinate.1]!.buildingNode.name!
    }
    
    func isExistBuiling(on coordinate: (Int, Int)) -> Bool {
        buildings[coordinate.0][coordinate.1] != nil
    }
    
}
