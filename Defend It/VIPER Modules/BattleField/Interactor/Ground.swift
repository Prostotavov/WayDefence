//
//  Ground.swift
//  Defend It
//
//  Created by MacBook Pro on 19.03.22.
//

import SceneKit

protocol Ground {
    mutating func createGround(size: Int) -> [[GroundCell]]
}

struct GroundImpl: Ground {
    var allElementsScene: SCNScene!
    var lightGroundCell: SCNNode!
    var darkGroundCell: SCNNode!
    
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
    }
    
    mutating func createGround(size: Int) -> [[GroundCell]] {
        print("createGround in GroundImpl")
        var ground: [[GroundCell]] = []
        for x in 0..<size {
            var row: [GroundCell] = []
            for z in 0..<size {
                var cell = GroundCellImpl()
                var geometry: SCNGeometry!
                ((x + z) % 2 == 0) ? (geometry = lightGroundCell.geometry) : (geometry = darkGroundCell.geometry)
                cell.scnGroundNode.geometry = geometry
                cell.scnGroundNode.name = "groundCell"
                cell.scnGroundNode.position = SCNVector3(Float(x)/2, 0, Float(z)/2)
                cell.coordinate = (x, z)
                row.append(cell)
            }
            ground.append(row)
        }
        return ground
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
