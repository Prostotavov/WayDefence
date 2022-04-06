//
//  TrollFactory.swift
//  Defend It
//
//  Created by MacBook Pro on 26.03.22.
//

import SceneKit

class TrollFactory: AbstractFactoryEnemies {
    
    private let trollSceneFL: SCNScene!
    private let trollSceneSL: SCNScene!
    private let trollSceneTL: SCNScene!
    
    private let trollNodeFL: SCNNode!
    private let trollNodeSL: SCNNode!
    private let trollNodeTL: SCNNode!
    
    init() {
        trollSceneFL = SCNScene(named: ScenePaths.trollFLScene.rawValue)
        trollSceneSL = SCNScene(named: ScenePaths.trollSLScene.rawValue)
        trollSceneTL = SCNScene(named: ScenePaths.trollTLScene.rawValue)
        
        trollNodeFL = trollSceneFL.rootNode.childNode(withName: EnemyNodes.trollFL.rawValue, recursively: true)
        trollNodeSL = trollSceneSL.rootNode.childNode(withName: EnemyNodes.trollSL.rawValue, recursively: true)
        trollNodeTL = trollSceneTL.rootNode.childNode(withName: EnemyNodes.trollTL.rawValue, recursively: true)
    }
    
    static let defaultFactory = TrollFactory()
    
    func createFirstLevelEnemy() -> AnyEnemy {
        AnyEnemy(TrollFL(trollNodeFL.clone()))
    }
    
    func createSecondLevelEnemy() -> AnyEnemy {
        AnyEnemy(TrollSL(trollNodeSL.clone()))
    }
    
    func createThirdLevelEnemy() -> AnyEnemy {
        AnyEnemy(TrollTL(trollNodeTL.clone()))
    }

}
