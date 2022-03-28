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
        
        trollNodeFL = trollSceneFL.rootNode.childNode(withName: NodeNames.trollFL.rawValue, recursively: true)
        trollNodeSL = trollSceneSL.rootNode.childNode(withName: NodeNames.trollSL.rawValue, recursively: true)
        trollNodeTL = trollSceneTL.rootNode.childNode(withName: NodeNames.trollTL.rawValue, recursively: true)
    }
    
    static let defaultFactory = TrollFactory()
    
    func createFirstLevelEnemy() -> Enemy {
        return TrollFL(trollNodeFL)
    }
    
    func createSecondLevelEnemy() -> Enemy {
        return TrollSL(trollNodeSL)
    }
    
    func createThirdLevelEnemy() -> Enemy {
        return TrollTL(trollNodeTL)
    }

}
