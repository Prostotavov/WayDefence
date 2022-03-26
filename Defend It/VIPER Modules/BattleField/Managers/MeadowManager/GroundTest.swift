//
//  GroundTest.swift
//  Defend It
//
//  Created by MacBook Pro on 26.03.22.
//

import SceneKit

protocol GroundTest {
    var ground: [[GroundCell]] {get set}
    func createGround(size: Int) -> [[GroundCell]]
}

class GroundTestImpl: GroundTest {
    
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
}
