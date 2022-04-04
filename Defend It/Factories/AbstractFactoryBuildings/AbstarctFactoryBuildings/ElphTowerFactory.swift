//
//  ElphTowerFactory.swift
//  Defend It
//
//  Created by MacBook Pro on 19.03.22.
//

import SceneKit

class ElphTowerFactory: AbstactFactoryBuildings {
    
    private let elphTowerSceneFL: SCNScene!
    private let elphTowerSceneSL: SCNScene!
    private let elphTowerSceneTL: SCNScene!
    
    private let elphTowerNodeFL: SCNNode!
    private let elphTowerNodeSL: SCNNode!
    private let elphTowerNodeTL: SCNNode!
    
    init() {
        elphTowerSceneFL = SCNScene(named: ScenePaths.elphTowerFLScene.rawValue)
        elphTowerSceneSL = SCNScene(named: ScenePaths.elphTowerSLScene.rawValue)
        elphTowerSceneTL = SCNScene(named: ScenePaths.elphTowerTLScene.rawValue)
        
        elphTowerNodeFL = elphTowerSceneFL.rootNode.childNode(withName: NodeNames.elphTowerFL.rawValue, recursively: true)
        elphTowerNodeSL = elphTowerSceneSL.rootNode.childNode(withName: NodeNames.elphTowerSL.rawValue, recursively: true)
        elphTowerNodeTL = elphTowerSceneTL.rootNode.childNode(withName: NodeNames.elphTowerTL.rawValue, recursively: true)
    }
    
    static let defaultFactory = ElphTowerFactory()
    
    func createFirstLevelBuildings() -> Building {
        return ElphTowerFL(elphTowerNodeFL.clone())
    }
    
    func createSecondLevelBuildings() -> Building {
        return ElphTowerSL(elphTowerNodeSL.clone())
    }
    
    func createThirdLevelBuildings() -> Building {
        return ElphTowerSL(elphTowerNodeTL.clone())
    }
}
