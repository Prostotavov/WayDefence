//
//  BuildingsManager.swift
//  Defend It
//
//  Created by MacBook Pro on 21.03.22.
//

import SceneKit

protocol BuildingsManager {
    func showTowerSelectionPanel(On position: SCNVector3) -> SCNNode

    func create(_ buildingType: BuildingTypes, with level: BuildingLevels, and position: SCNVector3) -> Building
    func getUpgradeBuilding(for coordinate: (Int, Int)) -> Building
    
    func getBuildingName(with coordinate: (Int, Int)) -> String
    func isExistBuiling(on coordinate: (Int, Int)) -> Bool
    
    func deleteBuilding(with coordinate: (Int, Int))
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
        let coordinate = Converter.toCoordinate(from: position)
        if isExistBuiling(on: coordinate) {
            return towerSelectionPanel.show(for: buildings[coordinate.0][coordinate.1]!)
        } else {
            return towerSelectionPanel.show(on: position)
        }
    }
    
    func create(_ buildingType: BuildingTypes, with level: BuildingLevels, and position: SCNVector3) -> Building {
        let coordinate = Converter.toCoordinate(from: position)
        let building = AbstactFactoryBuildingsImpl.defaultFactory.create(buildingType, with: level)
        building.buildingNode.position = position
        building.buildingNode.name = "building(\(coordinate.0),\(coordinate.1))"
        buildings[coordinate.0][coordinate.1] = building
        return building
    }
    
    func getUpgradeBuilding(for coordinate: (Int, Int)) -> Building {
        let building = buildings[coordinate.0][coordinate.1]!
        let name = building.buildingNode.name!
        let type = building.type
        let level = getNextLevel(after: building.level)
        let upgradeBuilding = AbstactFactoryBuildingsImpl.defaultFactory.create(type, with: level)
        upgradeBuilding.buildingNode.position = buildings[coordinate.0][coordinate.1]!.buildingNode.position
        upgradeBuilding.buildingNode.name = name
        buildings[coordinate.0][coordinate.1] = upgradeBuilding
        return upgradeBuilding
    }
    
    private func getNextLevel(after level: BuildingLevels) -> BuildingLevels {
        switch level {
        case .firstLevel:
            return .secondLevel
        case .secondLevel:
            return .thirdLevel
        case .thirdLevel:
            return .thirdLevel
        }
    }
    
    func deleteBuilding(with coordinate: (Int, Int)) {
        buildings[coordinate.0][coordinate.1] = nil
    }
    
    func getBuildingName(with coordinate: (Int, Int)) -> String {
        buildings[coordinate.0][coordinate.1]!.buildingNode.name!
    }
    
    func isExistBuiling(on coordinate: (Int, Int)) -> Bool {
        buildings[coordinate.0][coordinate.1] != nil
    }
    
}
