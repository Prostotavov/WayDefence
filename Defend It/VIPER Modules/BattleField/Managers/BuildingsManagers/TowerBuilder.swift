//
//  Building.swift
//  Defend It
//
//  Created by MacBook Pro on 19.03.22.
//

import SceneKit

protocol TowerBuilder {
    func build(_ building: BuildingTypes, On position: SCNVector3) ->  Building
}

class TowerBuilderImpl: TowerBuilder {
    
    func build(_ building: BuildingTypes, On position: SCNVector3) ->  Building {
        let tower: Building
        switch building {
        case .magicTower: tower = MagicTowerFactory.defaultFactory.createFirstLevelBuildings()
        case .elphTower: tower = ElphTowerFactory.defaultFactory.createFirstLevelBuildings()
        case .ballista : tower = BallistaFactory.defaultFactory.createFirstLevelBuildings()
        case .wall : tower = WallFactory.defaultFactory.createFirstLevelBuildings()
        }
        tower.buildingNode.position = position
        let coordinate = Converter.toCoordinate(from: position)
        tower.buildingNode.name! += "(\(coordinate.0),\(coordinate.1))"
        return tower
    }
    
}


