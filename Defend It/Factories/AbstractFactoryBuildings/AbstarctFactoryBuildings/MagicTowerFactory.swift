//
//  MagicTowerFactory.swift
//  Defend It
//
//  Created by MacBook Pro on 19.03.22.
//

import SceneKit

class MagicTowerFactory: AbstactFactoryBuildings {
    
    private let magicTowerSceneFL: SCNScene!
    private let magicTowerSceneSL: SCNScene!
    private let magicTowerSceneTL: SCNScene!
    
    private let magicTowerNodeFL: SCNNode!
    private let magicTowerNodeSL: SCNNode!
    private let magicTowerNodeTL: SCNNode!
    
    init() {
        magicTowerSceneFL = SCNScene(named: ScenePaths.magicTowerFLScene.rawValue)
        magicTowerSceneSL = SCNScene(named: ScenePaths.magicTowerSLScene.rawValue)
        magicTowerSceneTL = SCNScene(named: ScenePaths.magicTowerTLScene.rawValue)
        
        magicTowerNodeFL = magicTowerSceneFL.rootNode.childNode(withName: NodeNames.magicTowerFL.rawValue, recursively: true)
        magicTowerNodeSL = magicTowerSceneSL.rootNode.childNode(withName: NodeNames.magicTowerSL.rawValue, recursively: true)
        magicTowerNodeTL = magicTowerSceneTL.rootNode.childNode(withName: NodeNames.magicTowerTL.rawValue, recursively: true)
    }
    
    static let defaultFactory = MagicTowerFactory()
    
    func createFirstLevelBuildings() -> Building {
        return MagicTowerFL(magicTowerNodeFL.clone())
    }
    
    func createSecondLevelBuildings() -> Building {
        return MagicTowerSL(magicTowerNodeSL.clone())
    }
    
    func createThirdLevelBuildings() -> Building {
        return MagicTowerTL(magicTowerNodeTL.clone())
    }
}
