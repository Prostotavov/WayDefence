//
//  GoblinFactory.swift
//  Defend It
//
//  Created by MacBook Pro on 26.03.22.
//

import SceneKit

class GoblinFactory: AbstractFactoryEnemies {
    
    private let goblinSceneFL: SCNScene!
    private let goblinSceneSL: SCNScene!
    private let goblinSceneTL: SCNScene!
    
    private let goblinNodeFL: SCNNode!
    private let goblinNodeSL: SCNNode!
    private let goblinNodeTL: SCNNode!
    
    init() {
        goblinSceneFL = SCNScene(named: ScenePaths.goblinFLScene.rawValue)
        goblinSceneSL = SCNScene(named: ScenePaths.goblinSLScene.rawValue)
        goblinSceneTL = SCNScene(named: ScenePaths.goblinTLScene.rawValue)
        
        goblinNodeFL = goblinSceneFL.rootNode.childNode(withName: NodeNames.goblinFL.rawValue, recursively: true)
        goblinNodeSL = goblinSceneSL.rootNode.childNode(withName: NodeNames.goblinSL.rawValue, recursively: true)
        goblinNodeTL = goblinSceneTL.rootNode.childNode(withName: NodeNames.goblinTL.rawValue, recursively: true)
    }
    
    static let defaultFactory = GoblinFactory()
    
    func createFirstLevelEnemy() -> Enemy {
        return GoblinFL(goblinNodeFL)
    }
    
    func createSecondLevelEnemy() -> Enemy {
        return GoblinSL(goblinNodeSL)
    }
    
    func createThirdLevelEnemy() -> Enemy {
        return GoblinTL(goblinNodeTL)
    }

}
