//
//  OrcFactory.swift
//  Defend It
//
//  Created by MacBook Pro on 26.03.22.
//

import SceneKit

class OrcFactory: AbstractFactoryEnemies {
    
    private let orcScene: SCNScene!
    private let orcNode: SCNNode!
    
    init() {
        orcScene = SCNScene(named: ScenePaths.magicTowerScene.rawValue)
        orcNode = orcScene.rootNode.childNode(withName: NodeNames.magicTower.rawValue, recursively: true)
    }
    
    static let defaultFactory = OrcFactory()
    
    
    func createFirstLevelEnemy() -> EnemyTest {
        return OrcFL(orcNode)
    }
    
    func createSecondLevelEnemy() -> EnemyTest {
        return OrcSL(orcNode)
    }
    
    func createThirdLevelEnemy() -> EnemyTest {
        return OrcTL(orcNode)
    }

}
