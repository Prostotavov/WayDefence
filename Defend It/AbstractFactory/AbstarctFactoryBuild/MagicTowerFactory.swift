//
//  MagicTowerFactory.swift
//  Defend It
//
//  Created by MacBook Pro on 19.03.22.
//

import Foundation

struct MagicTowerFactory: AbstactFactoryBuildings {
    
    static let defaultFactory = MagicTowerFactory()
    
    func createFirstLevelBuildings() -> Building {
        return MagicTowerFL()
    }
    
    func createSecondLevelBuildings() -> Building {
        return MagicTowerSL()
    }
}
