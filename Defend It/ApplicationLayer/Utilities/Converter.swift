//
//  Converter.swift
//  Defend It
//
//  Created by MacBook Pro on 21.03.22.
//

import SceneKit

struct GameConstants {
    
    static let goundSquareSize: CGFloat = 1 / 8 // smallest unit of length
}

struct Converter {
    
    static func toCoordinate(from position: SCNVector3) -> (Int, Int) {
        (Int(round(CGFloat(position.x) / GameConstants.goundSquareSize)),
         Int(round(CGFloat(position.z) / GameConstants.goundSquareSize)))
    }
    
    static func toPosition(from coordinate: (Int, Int)) -> SCNVector3 {
        SCNVector3(CGFloat(coordinate.0) * GameConstants.goundSquareSize, 0,
                   CGFloat(coordinate.1) * GameConstants.goundSquareSize)
    }
    
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
    
    // enemy speed = count of squares completed per minute
    static func toTimeInterval(from speed: Int) -> TimeInterval {
        TimeInterval(Float(10/Float(speed)))
    }
    
    static func toCounter(from speed: Int) -> Int {
        100 / speed
    }
    
    static func toDistination(between position: SCNVector3, and target: SCNVector3) -> Double {
        // the enemy only moves up or down, which means that:
        // position.z = target.z or position.x = target.x
        let xDist = abs(position.z - target.z)
        let zDist = abs(position.x - target.x)
        return Double(sqrt((pow(xDist, 2) + pow(zDist, 2))))
    }
    
    static func toCounter(from timeInterval: TimeInterval) -> Int {
        Int(timeInterval * 60)
    }
    
    static func toBuildingType(from nodeName: String) -> BuildingTypes? {
        switch nodeName {
        case _ where nodeName.contains(BuildingTypes.elphTower.rawValue) :
            return .elphTower
        case _ where nodeName.contains(BuildingTypes.magicTower.rawValue) :
            return .magicTower
        case _ where nodeName.contains(BuildingTypes.ballista.rawValue) :
            return .ballista
        case _ where nodeName.contains(BuildingTypes.wall.rawValue) :
            return .wall
        default: return nil
        }
    }
    
    static func toBuildingLevel(from nodeName: String) -> BuildingLevels? {
        if nodeName.contains("FL") {return .firstLevel}
        if nodeName.contains("SL") {return .secondLevel}
        if nodeName.contains("TL") {return .thirdLevel}
        return nil
    }
    
    static func toBuiltTower(from nodeName: String) -> BuiltTowers {
        let type = toBuildingType(from: nodeName)!
        let level = toBuildingLevel(from: nodeName)!
        switch type {
        case .elphTower:
            switch level {
            case .firstLevel : return .elphTowerFL
            case .secondLevel : return .elphTowerSL
            case .thirdLevel : return .elphTowerTL
            }
        case .magicTower:
            switch level {
            case .firstLevel : return .magicTowerFL
            case .secondLevel : return .magicTowerSL
            case .thirdLevel : return .magicTowerTL
            }
        case .ballista:
            switch level {
            case .firstLevel : return .ballistaFL
            case .secondLevel : return .ballistaSL
            case .thirdLevel : return .ballistaTL
            }
        case .wall:
            switch level {
            case .firstLevel : return .wallFL
            case .secondLevel : return .wallSL
            case .thirdLevel : return .wallTL
            }
        }
    }
    
    static func toPosition(from translation: CGPoint) -> SCNVector3 {
        let sensity: Float = 140
        return SCNVector3(x: Float(translation.x) / sensity, y: 0, z: Float(translation.y) / sensity)
    }
    
}

