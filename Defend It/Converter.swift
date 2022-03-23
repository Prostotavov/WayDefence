//
//  Converter.swift
//  Defend It
//
//  Created by MacBook Pro on 21.03.22.
//

import SceneKit

struct Converter {
    
    static func toCoordination(From position: SCNVector3) -> (Int, Int) {
        (Int(round(position.x * 2)), Int(round(position.z * 2)))
    }
    
    static func toPosition(From coordinate: (Int, Int)) -> SCNVector3 {
        SCNVector3(Float(coordinate.0)/2, 0, Float(coordinate.1)/2)
    }
    
    // for arrays
    
    static func toCoordinations(From positions: [SCNVector3]) -> [(Int, Int)] {
        positions.map{ toCoordination(From: $0) }
    }
    
    static func toPositions(From coordinates: [(Int, Int)]) -> [SCNVector3] {
        coordinates.map{ toPosition(From: $0) }
    }
    
}

