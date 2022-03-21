//
//  Ground.swift
//  Defend It
//
//  Created by MacBook Pro on 19.03.22.
//

import SceneKit

protocol Ground {
    mutating func createGround(size: Int) -> [[GroundCell]]
    mutating func create(_ building: Buildings, On position: SCNVector3, And coordinate: (Int, Int)) ->  SCNNode
}

struct GroundImpl: Ground {
    var allElementsScene: SCNScene!
    var lightGroundCell: SCNNode!
    var darkGroundCell: SCNNode!
    var magicTower: SCNNode!
    var elphTower: SCNNode!
    var ground: [[GroundCell]] = []
    
    init() {
        setupScene()
        setupNodes()
    }
    
    mutating func setupScene() {
        allElementsScene = SCNScene(named: "art.scnassets/allElements.scn")!
    }
    
    mutating func setupNodes() {
        lightGroundCell = allElementsScene.rootNode.childNode(withName: "lightGround", recursively: true)!
        darkGroundCell = allElementsScene.rootNode.childNode(withName: "darkGround", recursively: true)!
        magicTower = allElementsScene.rootNode.childNode(withName: "magicTower", recursively: true)!
        elphTower = allElementsScene.rootNode.childNode(withName: "elphTower", recursively: true)!
    }
    
    mutating func createGround(size: Int) -> [[GroundCell]] {

        for x in 0..<size {
            var row: [GroundCell] = []
            for z in 0..<size {
                var cell = GroundCellImpl()
                var geometry: SCNGeometry!
                
                ((x + z) % 2 == 0) ? (geometry = lightGroundCell.geometry) : (geometry = darkGroundCell.geometry)
                cell.scnGroundNode.geometry = geometry
                cell.scnGroundNode.name = "groundCell"
                cell.coordinate = (x, z)
                row.append(cell)
            }
            ground.append(row)
        }
        return ground
    }
    
    mutating func create(_ building: Buildings, On position: SCNVector3, And coordinate: (Int, Int)) ->  SCNNode {
        let tower: SCNNode
        switch building {
        case .magicTower: tower = magicTower.clone()
        case .elphTower: tower = elphTower.clone()
        }
        tower.position = position
        ground[coordinate.0][coordinate.1].scnBuildingNode = magicTower
        return tower
    }
    
}

protocol GroundCell {
    var coordinate: (Int, Int) {get set}
    var scnGroundNode: SCNNode {get set}
    var scnBuildingNode: SCNNode? {get set}
}

struct GroundCellImpl: GroundCell {
    var coordinate: (Int, Int) = (0, 0)
    var scnGroundNode: SCNNode = SCNNode()
    var scnBuildingNode: SCNNode?
}
