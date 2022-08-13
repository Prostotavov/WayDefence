//
//  BattleMeadow.swift
//  Defend It
//
//  Created by MacBook Pro on 26.03.22.
//

import SceneKit

protocol BattleMeadow {
    var squares: [[GroundSquareImpl]]! {get set}
    var size: Int! {get set}
}

class BattleMeadowImpl: BattleMeadow, Equatable {
    
    var squareScene: SCNScene!
    var squareNode: SCNNode!
    var squares: [[GroundSquareImpl]]!
    var size: Int!
    
    init(size: Int) {
        self.size = size
        setupScene()
        setupNodes()
        createGround(size: size)
    }
    
    private func setupScene() {
        squareScene = SCNScene(named: ScenePaths.groundSquareScene.rawValue)!
    }
    
    private func setupNodes() {
        squareNode = squareScene.rootNode.childNode(withName: NodeNames.groundSquare.rawValue, recursively: true)!
    }
    
    private func createGround(size: Int) {
        squares = []
        for x in 0..<size {
            var squaresRow: [GroundSquareImpl] = []
            for z in 0..<size {
                let square = GroundSquareImpl()
                square.scnNode = squareNode.clone()
                square.coordinate = (x, z)
                square.scnNode.position = Converter.toPosition(from: (x, z))
                squaresRow.append(square)
            }
            squares.append(squaresRow)
        }
    }
    
    static func == (lhs: BattleMeadowImpl, rhs: BattleMeadowImpl) -> Bool {
        return lhs.squareScene == rhs.squareScene &&
        lhs.squareNode == rhs.squareNode &&
        lhs.squares == rhs.squares
    }
}
