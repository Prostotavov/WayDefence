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
}

class MeadowManagerImpl: MeadowManager {
    var ground: Ground!
    var battleFieldSize: Int!
    weak var delegate: MeadowManagerDelagate!
    
    init(_ battleFieldSize: Int) {
        self.battleFieldSize = battleFieldSize
        createGround(size: battleFieldSize)
    }
    
    private func createGround(size: Int) {
        ground = GroundImpl(size: size)
    }
    
    func addGroundToScene() {
        for squaresRow in ground.squares {
            for square in squaresRow {
                delegate.addNodeToScene(square.scnNode)
            }
        }
    }
    
    func getGroundSquares() ->  [[GroundSquareImpl]] {
        ground.squares
    }
}
