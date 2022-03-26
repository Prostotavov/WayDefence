//
//  TrollFactory.swift
//  Defend It
//
//  Created by MacBook Pro on 26.03.22.
//

import SceneKit

class TrollFactory: AbstractFactoryEnemies {
    
    private let trollScene: SCNScene!
    private let trollNode: SCNNode!
    
    init() {
        trollScene = SCNScene(named: ScenePaths.magicTowerScene.rawValue)
        trollNode = trollScene.rootNode.childNode(withName: NodeNames.magicTower.rawValue, recursively: true)
    }
    
    static let defaultFactory = OrcFactory()
    
    
    func createFirstLevelEnemy() -> EnemyTest {
        return TrollFL(trollNode)
    }
    
    func createSecondLevelEnemy() -> EnemyTest {
        return TrollSL(trollNode)
    }
    
    func createThirdLevelEnemy() -> EnemyTest {
        return TrollTL(trollNode)
    }

}
