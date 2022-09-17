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
    
    func isEmpty(coordinate: (Int, Int), forBuildingWith size: (Int, Int)) -> Bool
    func oppury(coordinate: (Int, Int), byBuildingWith size: (Int, Int))
    func free(coordinate: (Int, Int), byBuildingWith size: (Int, Int))
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
    
    private func isValid(coordinate: (Int, Int)) -> Bool {
        if !(0..<squares.count).contains(coordinate.0) {return false}
        if !(0..<squares.count).contains(coordinate.1) {return false}
        return true
    }

    func isEmpty(coordinate: (Int, Int), forBuildingWith size: (Int, Int)) -> Bool {
        let oppositeCoordinate: (Int, Int) = (coordinate.0 - size.0 + 1, coordinate.1 - size.1 + 1)
        if !isValid(coordinate: coordinate) {return false}
        if !isValid(coordinate: oppositeCoordinate) {return false}
        for xCoordinate in oppositeCoordinate.0...coordinate.0 {
            for zCoordinate in oppositeCoordinate.1...coordinate.1 {
                if squares[xCoordinate][zCoordinate].state == .occupied {return false}
            }
        }
        return true
    }
    
    func oppury(coordinate: (Int, Int), byBuildingWith size: (Int, Int)) {
        let oppositeCoordinate: (Int, Int) = (coordinate.0 - size.0 + 1, coordinate.1 - size.1 + 1)
        for xCoordinate in oppositeCoordinate.0...coordinate.0 {
            for zCoordinate in oppositeCoordinate.1...coordinate.1 {
                squares[xCoordinate][zCoordinate].state = .occupied
            }
        }
    }
    
    func free(coordinate: (Int, Int), byBuildingWith size: (Int, Int)) {
        let oppositeCoordinate: (Int, Int) = (coordinate.0 - size.0 + 1, coordinate.1 - size.1 + 1)
        for xCoordinate in oppositeCoordinate.0...coordinate.0 {
            for zCoordinate in oppositeCoordinate.1...coordinate.1 {
                squares[xCoordinate][zCoordinate].state = .empty
            }
        }
    }
}
