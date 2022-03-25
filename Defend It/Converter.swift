//
//  Converter.swift
//  Defend It
//
//  Created by MacBook Pro on 21.03.22.
//

import SceneKit

struct Converter {
    
    static func toCoordinate(from position: SCNVector3) -> (Int, Int) {
        (Int(round(position.x * 2)), Int(round(position.z * 2)))
    }
    
    static func toPosition(from coordinate: (Int, Int)) -> SCNVector3 {
        SCNVector3(Float(coordinate.0)/2, 0, Float(coordinate.1)/2)
    }
    
    // for arrays
    
    static func toCoordinates(from positions: [SCNVector3]) -> [(Int, Int)] {
        positions.map{ toCoordinate(from: $0) }
    }
    
    static func toPositions(from coordinates: [(Int, Int)]) -> [SCNVector3] {
        coordinates.map{ toPosition(from: $0) }
    }
    
    static func toCoordinate(from buildingName: String) -> (Int, Int) {
        // example: buildingName = "builtTower(5,6)"
        
        // bracketIndex = 10
        let bracketIndex = buildingName.firstIndex(of: "(")!
        
        // stringCoordinate = 5,6
        let stringCoordinate = buildingName[bracketIndex...].dropFirst().dropLast()

        // commaIndex = 1
        let commaIndex = stringCoordinate.firstIndex(of: ",")!
        
        // x = 5, z = 6
        let x = Int(stringCoordinate[..<commaIndex])!
        let z = Int(stringCoordinate[commaIndex...].dropFirst())!
        
        return (x, z)
    }
    
}

