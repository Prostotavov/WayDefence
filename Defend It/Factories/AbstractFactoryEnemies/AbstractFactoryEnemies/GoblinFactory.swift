//
//  GoblinFactory.swift
//  Defend It
//
//  Created by MacBook Pro on 26.03.22.
//

import SceneKit

class GoblinFactory: AbstractFactoryEnemies {
    
    private let goblinScene: SCNScene!
    private let goblinNode: SCNNode!
    
    init() {
        goblinScene = SCNScene(named: ScenePaths.magicTowerScene.rawValue)
        goblinNode = goblinScene.rootNode.childNode(withName: NodeNames.magicTower.rawValue, recursively: true)
    }
    
    static let defaultFactory = OrcFactory()
    
    
    func createFirstLevelEnemy() -> EnemyTest {
        return GoblinFL(goblinNode)
    }
    
    func createSecondLevelEnemy() -> EnemyTest {
        return GoblinSL(goblinNode)
    }
    
    func createThirdLevelEnemy() -> EnemyTest {
        return GoblinTL(goblinNode)
    }

}
