//
//  MeadowManager.swift
//  Defend It
//
//  Created by MacBook Pro on 26.03.22.
//

import SceneKit

protocol MeadowManagerDelagate: AnyObject {
    func addNodeToScene(_ node: SCNNode)
}

protocol MeadowManager {
    func getGroundSquares() -> [[GroundSquareImpl]]
    func addGroundToScene()
    
    func isEmpty(coordinate: inout (Int, Int), forBuildingWith size: (Int, Int)) -> Bool
    func oppury(coordinate: (Int, Int), byBuildingWith size: (Int, Int))
    func free(coordinate: (Int, Int), byBuildingWith size: (Int, Int))
}

class MeadowManagerImpl: MeadowManager {
    var battleMeadow: BattleMeadow!
    
    weak var delegate: MeadowManagerDelagate!
    
    init(ground: BattleMeadow) {
        self.battleMeadow = ground
    }
    
    func addGroundToScene() {
        for squaresRow in battleMeadow.squares {
            for square in squaresRow {
                delegate.addNodeToScene(square.scnNode)
            }
        }
    }
    
    func getGroundSquares() ->  [[GroundSquareImpl]] {
        battleMeadow.squares
    }
    func isEmpty(coordinate: inout (Int, Int), forBuildingWith size: (Int, Int)) -> Bool {
        battleMeadow.isEmpty(coordinate: &coordinate, forBuildingWith: size)
    }
    func oppury(coordinate: (Int, Int), byBuildingWith size: (Int, Int)) {
        battleMeadow.oppury(coordinate: coordinate, byBuildingWith: size)
    }
    func free(coordinate: (Int, Int), byBuildingWith size: (Int, Int)) {
        battleMeadow.free(coordinate: coordinate, byBuildingWith: size)
    }
}
