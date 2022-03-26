//
//  AbstactFactoryBuildings.swift
//  Defend It
//
//  Created by MacBook Pro on 19.03.22.
//

import Foundation

enum Buildings: String, CaseIterable {
    case magicTower
    case elphTower
}

enum BuildingLevels: String, CaseIterable {
    case firstLevel
    case secondLevel
}

protocol AbstactFactoryBuildings {
        
    func createFirstLevelBuildings() -> Building
    func createSecondLevelBuildings() -> Building
}
