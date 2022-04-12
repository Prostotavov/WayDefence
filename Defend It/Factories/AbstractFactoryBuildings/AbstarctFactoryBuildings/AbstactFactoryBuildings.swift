//
//  AbstactFactoryBuildings.swift
//  Defend It
//
//  Created by MacBook Pro on 19.03.22.
//

import Foundation

enum BuildingTypes: String, CaseIterable {
    case magicTower
    case elphTower
    case ballista
    case wall
}

enum BuildingLevels: String, CaseIterable {
    case firstLevel
    case secondLevel
    case thirdLevel
}

protocol AbstactFactoryBuildings {
        
    func createFirstLevelBuildings() -> Building
    func createSecondLevelBuildings() -> Building
    func createThirdLevelBuildings() -> Building
}

class AbstactFactoryBuildingsImpl {
    
    static let defaultFactory = AbstactFactoryBuildingsImpl()
    
    func create(_ building: BuildingTypes, with level: BuildingLevels) -> Building {
        switch building {
        case .elphTower:
            switch level {
            case .firstLevel:
                return ElphTowerFactory.defaultFactory.createFirstLevelBuildings()
            case .secondLevel:
                return ElphTowerFactory.defaultFactory.createSecondLevelBuildings()
            case .thirdLevel:
                return ElphTowerFactory.defaultFactory.createThirdLevelBuildings()
            }
            
        case .magicTower:
            switch level {
            case .firstLevel:
                return MagicTowerFactory.defaultFactory.createFirstLevelBuildings()
            case .secondLevel:
                return MagicTowerFactory.defaultFactory.createSecondLevelBuildings()
            case .thirdLevel:
                return MagicTowerFactory.defaultFactory.createThirdLevelBuildings()
            }
            
        case .ballista:
            switch level {
            case .firstLevel:
                return BallistaFactory.defaultFactory.createFirstLevelBuildings()
            case .secondLevel:
                return BallistaFactory.defaultFactory.createSecondLevelBuildings()
            case .thirdLevel:
                return BallistaFactory.defaultFactory.createThirdLevelBuildings()
            }
           
        case .wall:
            switch level {
            case .firstLevel:
                return WallFactory.defaultFactory.createFirstLevelBuildings()
            case .secondLevel:
                return WallFactory.defaultFactory.createSecondLevelBuildings()
            case .thirdLevel:
                return WallFactory.defaultFactory.createThirdLevelBuildings()
            }
        }
    }
    
}
