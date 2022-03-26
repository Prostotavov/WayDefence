//
//  Ground.swift
//  Defend It
//
//  Created by MacBook Pro on 19.03.22.
//

import SceneKit

protocol Ground {
    var ground: [[GroundCell]] {get set}
    func createGround(size: Int) -> [[GroundCell]]
    func build(_ building: Buildings, On position: SCNVector3) ->  SCNNode
    func deleteBuilding(with name: String)
    func get(_ building: Buildings) -> SCNNode
}

class GroundImpl: Ground {
    var groundCellScene: SCNScene!
    var groundCellNode: SCNNode!
    var ground: [[GroundCell]] = []
    
    init() {
        setupScene()
        setupNodes()
    }
    
    func setupScene() {
        groundCellScene = SCNScene(named: ScenePaths.groundCellScene.rawValue)!
    }
    
    func setupNodes() {
        groundCellNode = groundCellScene.rootNode.childNode(withName: NodeNames.groundCell.rawValue, recursively: true)!
    }
    
    func createGround(size: Int) -> [[GroundCell]] {

        for x in 0..<size {
            var row: [GroundCell] = []
            for z in 0..<size {
                var cell = GroundCellImpl()
                cell.scnGroundNode = groundCellNode.clone()
                cell.coordinate = (x, z)
                cell.scnGroundNode.position = Converter.toPosition(from: (x, z))
                row.append(cell)
            }
            ground.append(row)
        }
        return ground
    }
    
    func build(_ building: Buildings, On position: SCNVector3) ->  SCNNode {
        let tower: SCNNode
        switch building {
        case .magicTower: tower = MagicTowerFactory.defaultFactory.createFirstLevelBuildings().buildingNode.clone()
        case .elphTower: tower = ElphTowerFactory.defaultFactory.createFirstLevelBuildings().buildingNode.clone()
        }
        tower.position = position
        let coordinate = Converter.toCoordinate(from: position)
        tower.name = "builtTower(\(coordinate.0),\(coordinate.1))"
        ground[coordinate.0][coordinate.1].scnBuildingNode = tower
        return tower
    }
    
    func deleteBuilding(with name: String) {
        let coordinate = Converter.toCoordinate(from: name)
        ground[coordinate.0][coordinate.1].scnBuildingNode = nil
    }
    
    func get(_ building: Buildings) -> SCNNode {
        let tower: SCNNode
        switch building {
        case .magicTower: tower = MagicTowerFactory.defaultFactory.createFirstLevelBuildings().buildingNode.clone()
        case .elphTower: tower = ElphTowerFactory.defaultFactory.createFirstLevelBuildings().buildingNode.clone()
        }
        return tower
    }
    
}


