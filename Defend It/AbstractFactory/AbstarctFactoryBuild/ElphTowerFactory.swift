//
//  ElphTowerFactory.swift
//  Defend It
//
//  Created by MacBook Pro on 19.03.22.
//

import Foundation

struct ElphTowerFactory: AbstactFactoryBuildings {
    
    static let defaultFactory = ElphTowerFactory()
    
    func createFirstLevelBuildings() -> Building {
        return ElphTowerFL()
    }
    
    func createSecondLevelBuildings() -> Building {
        return ElphTowerSL()
    }
}
