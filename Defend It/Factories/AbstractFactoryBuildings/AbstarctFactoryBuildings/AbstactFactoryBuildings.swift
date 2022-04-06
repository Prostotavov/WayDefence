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
