//
//  Building.swift
//  Defend It
//
//  Created by MacBook Pro on 19.03.22.
//

import SceneKit

protocol TowerBuilder {
    func build(_ building: Buildings, On position: SCNVector3) ->  SCNNode
    func deleteBuilding(with name: String)
}

class TowerBuilderImpl: TowerBuilder {

    func build(_ building: Buildings, On position: SCNVector3) ->  SCNNode {
        let tower: SCNNode
        switch building {
        case .magicTower: tower = MagicTowerFactory.defaultFactory.createFirstLevelBuildings().buildingNode.clone()
        case .elphTower: tower = ElphTowerFactory.defaultFactory.createFirstLevelBuildings().buildingNode.clone()
        }
        tower.position = position
        let coordinate = Converter.toCoordinate(from: position)
        tower.name = "builtTower(\(coordinate.0),\(coordinate.1))"
        return tower
    }
    
    func deleteBuilding(with name: String) {
//        let coordinate = Converter.toCoordinate(from: name)
//        ground[coordinate.0][coordinate.1].scnBuildingNode = nil
    }

    
}


