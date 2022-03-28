//
//  OrcFactory.swift
//  Defend It
//
//  Created by MacBook Pro on 26.03.22.
//

import SceneKit

class OrcFactory: AbstractFactoryEnemies {
    
    private let orcSceneFL: SCNScene!
    private let orcSceneSL: SCNScene!
    private let orcSceneTL: SCNScene!
    
    private let orcNodeFL: SCNNode!
    private let orcNodeSL: SCNNode!
    private let orcNodeTL: SCNNode!
    
    init() {
        orcSceneFL = SCNScene(named: ScenePaths.orcFLScene.rawValue)
        orcSceneSL = SCNScene(named: ScenePaths.orcSLScene.rawValue)
        orcSceneTL = SCNScene(named: ScenePaths.orcTLScene.rawValue)
        
        orcNodeFL = orcSceneFL.rootNode.childNode(withName: NodeNames.orcFL.rawValue, recursively: true)
        orcNodeSL = orcSceneSL.rootNode.childNode(withName: NodeNames.orcSL.rawValue, recursively: true)
        orcNodeTL = orcSceneTL.rootNode.childNode(withName: NodeNames.orcTL.rawValue, recursively: true)
    }
    
    static let defaultFactory = OrcFactory()
    
    func createFirstLevelEnemy() -> Enemy {
        return OrcFL(orcNodeFL)
    }
    
    func createSecondLevelEnemy() -> Enemy {
        return OrcSL(orcNodeSL)
    }
    
    func createThirdLevelEnemy() -> Enemy {
        return OrcTL(orcNodeTL)
    }

}
