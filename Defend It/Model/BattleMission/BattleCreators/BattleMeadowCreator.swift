//
//  BattleMeadowCreator.swift
//  Defend It
//
//  Created by Роман Сенкевич on 9.07.22.
//

import Foundation
import UIKit
import SceneKit

protocol BattleMeadowCreator {
    func getBattleMeadow() -> BattleMeadow
    func add(groundType: GroundSquareTypes, on coordinates: [(Int, Int)])
}

class BattleMeadowCreatorImpl: BattleMeadowCreator {
    var battleMeadow: BattleMeadow
    
    init(size: Int) {
        self.battleMeadow = BattleMeadowImpl(size: size)
    }
    
    func getBattleMeadow() -> BattleMeadow {
        battleMeadow
    }
    
    func add(groundType: GroundSquareTypes, on coordinates: [(Int, Int)]) {
        switch groundType {
        case .grass: addGrass(on: coordinates)
        case .water: addWater(on: coordinates)
        case .forest: addForest(on: coordinates)
        case .swamp: addSwamp(on: coordinates)
        case .snow: addSnow(on: coordinates)
        case .lava: addLava(on: coordinates)
        case .rock: addRock(on: coordinates)
        case .deadLand: addDeadLand(on: coordinates)
        }
    }
    
    func addGrass(on coordinates: [(Int, Int)]) {
        for coordinate in coordinates {
            let square = battleMeadow.squares[coordinate.0][coordinate.1]
            square.scnNode.opacity = 0.5
            addColor(.green, to: square.scnNode)
            square.type = .grass
        }
    }
    
    func addWater(on coordinates: [(Int, Int)]) {
        for coordinate in coordinates {
            let square = battleMeadow.squares[coordinate.0][coordinate.1]
            square.scnNode.opacity = 0.5
            addColor(.blue, to: square.scnNode)
            square.type = .water
        }
    }
    
    func addForest(on coordinates: [(Int, Int)]) {
        for coordinate in coordinates {
            let square = battleMeadow.squares[coordinate.0][coordinate.1]
            square.scnNode.opacity = 0.5
            addColor(.green, to: square.scnNode)
            square.type = .forest
        }
    }
    
    func addSwamp(on coordinates: [(Int, Int)]) {
        for coordinate in coordinates {
            let square = battleMeadow.squares[coordinate.0][coordinate.1]
            square.scnNode.opacity = 0.5
            addColor(.brown, to: square.scnNode)
            square.type = .swamp
        }
    }
    
    func addSnow(on coordinates: [(Int, Int)]) {
        for coordinate in coordinates {
            let square = battleMeadow.squares[coordinate.0][coordinate.1]
            square.scnNode.opacity = 0.5
            addColor(.white, to: square.scnNode)
            square.type = .snow
        }
    }
    
    func addLava(on coordinates: [(Int, Int)]) {
        for coordinate in coordinates {
            let square = battleMeadow.squares[coordinate.0][coordinate.1]
            square.scnNode.opacity = 0.5
            addColor(.orange, to: square.scnNode)
            square.type = .lava
        }
    }
    
    func addRock(on coordinates: [(Int, Int)]) {
        for coordinate in coordinates {
            let square = battleMeadow.squares[coordinate.0][coordinate.1]
            square.scnNode.opacity = 0.5
            addColor(.gray, to: square.scnNode)
            square.type = .rock
        }
    }
    
    func addDeadLand(on coordinates: [(Int, Int)]) {
        for coordinate in coordinates {
            let square = battleMeadow.squares[coordinate.0][coordinate.1]
            square.scnNode.opacity = 0.5
            addColor(.black, to: square.scnNode)
            square.type = .deadLand
        }
    }
}

extension BattleMeadowCreatorImpl {
    func addColor(_ color: UIColor, to node: SCNNode) {
        let colorNode = SCNNode(geometry: SCNBox(width: 0.5, height: 0.01, length: 0.5, chamferRadius: 0))
        colorNode.geometry?.firstMaterial?.diffuse.contents = color
        node.addChildNode(colorNode)
    }
}

