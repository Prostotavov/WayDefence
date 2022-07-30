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
}
