//
//  GroundSquare.swift
//  Defend It
//
//  Created by MacBook Pro on 21.03.22.
//

import SceneKit

protocol GroundSquare: Hashable {
    var coordinate: (Int, Int)! {get set}
    var scnNode: SCNNode! {get set}
    var type: GroundSquareTypes {get set}
    var state: GroundSquareState {get set}
}

class GroundSquareImpl: GroundSquare, Hashable {
    var coordinate: (Int, Int)!
    var scnNode: SCNNode!
    var type: GroundSquareTypes = .grass
    var state: GroundSquareState = .empty
    
    static func == (lhs: GroundSquareImpl, rhs: GroundSquareImpl) -> Bool {
        return lhs.coordinate == rhs.coordinate &&
        lhs.scnNode == rhs.scnNode
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(coordinate.0)
        hasher.combine(coordinate.1)
        hasher.combine(scnNode)
    }
}

enum GroundSquareTypes {
    case grass
    case water
    case forest
    case swamp
    case snow
    case lava
    case rock
    case deadLand
}

enum GroundSquareState {
    case empty
    case occupied
}

