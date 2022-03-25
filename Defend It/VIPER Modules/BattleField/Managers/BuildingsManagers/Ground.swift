//
//  Ground.swift
//  Defend It
//
//  Created by MacBook Pro on 19.03.22.
//

import SceneKit

protocol Ground {
    var ground: [[GroundCell]] {get set}
    mutating func createGround(size: Int) -> [[GroundCell]]
    mutating func build(_ building: Buildings, On position: SCNVector3) ->  SCNNode
    mutating func deleteBuilding(with name: String)
}

struct GroundImpl: Ground {
    var groundCellScene: SCNScene!
    var groundCellNode: SCNNode!
    
    var elphTowerScene: SCNScene!
    var elphTowerNode: SCNNode!
    
    var magicTowerScene: SCNScene!
    var magicTowerNode: SCNNode!
    
    var ground: [[GroundCell]] = []
    
    init() {
        setupScene()
        setupNodes()
    }
    
    mutating func setupScene() {
        groundCellScene = SCNScene(named: ScenePaths.groundCellScene.rawValue)!
        elphTowerScene = SCNScene(named: ScenePaths.elphTowerScene.rawValue)!
        magicTowerScene = SCNScene(named: ScenePaths.magicTowerScene.rawValue)!
    }
    
    mutating func setupNodes() {
        groundCellNode = groundCellScene.rootNode.childNode(withName: NodeNames.groundCell.rawValue, recursively: true)!
        elphTowerNode = elphTowerScene.rootNode.childNode(withName: NodeNames.elphTower.rawValue, recursively: true)!
        magicTowerNode = magicTowerScene.rootNode.childNode(withName: NodeNames.magicTower.rawValue, recursively: true)!
        
    }
    
    mutating func createGround(size: Int) -> [[GroundCell]] {

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
    
    mutating func build(_ building: Buildings, On position: SCNVector3) ->  SCNNode {
        let tower: SCNNode
        switch building {
        case .magicTower: tower = magicTowerNode.clone()
        case .elphTower: tower = elphTowerNode.clone()
        }
        tower.position = position
        let coordinate = Converter.toCoordinate(from: position)
        tower.name = "builtTower(\(coordinate.0),\(coordinate.1))"
        ground[coordinate.0][coordinate.1].scnBuildingNode = tower
        return tower
    }
    
    mutating func deleteBuilding(with name: String) {
        let coordinate = Converter.toCoordinate(from: name)
        ground[coordinate.0][coordinate.1].scnBuildingNode = nil
    }
    
}


