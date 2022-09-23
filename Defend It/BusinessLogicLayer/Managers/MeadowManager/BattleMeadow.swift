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
    
    func isEmpty(coordinate: inout (Int, Int), forBuildingWith size: (Int, Int)) -> Bool
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
    
    // this func handle coordinate.  battleFieldSize = 10x10 and buildingSize = 3x3
    // example 1: input coordinate = (-4, 6) -> output coordinate = (2, 6)
    // example 2: input coordinate = (11, -2) -> output coordinate = (10, 2)
    private func setRange(for coordinate: inout (Int, Int), with buildingSize: (Int, Int)) {
        if coordinate.0 < buildingSize.0 {coordinate.0 = buildingSize.0 - 1}
        if coordinate.1 < buildingSize.1 {coordinate.1 = buildingSize.1 - 1}
        
        if coordinate.0 > size {coordinate.0 = size}
        if coordinate.1 > size {coordinate.1 = size}
    }

    func isEmpty(coordinate: inout (Int, Int), forBuildingWith size: (Int, Int)) -> Bool {
        
        setRange(for: &coordinate, with: size)
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
