//
//  BallistaFactory.swift
//  Defend It
//
//  Created by MacBook Pro on 4.04.22.
//

import SceneKit

class BallistaFactory: AbstactFactoryBuildings {
    
    private let ballistaSceneFL: SCNScene!
    private let ballistaSceneSL: SCNScene!
    private let ballistaSceneTL: SCNScene!
    
    private let ballistaNodeFL: SCNNode!
    private let ballistaNodeSL: SCNNode!
    private let ballistaNodeTL: SCNNode!
    
    init() {
        ballistaSceneFL = SCNScene(named: ScenePaths.ballistaFLScene.rawValue)
        ballistaSceneSL = SCNScene(named: ScenePaths.ballistaSLScene.rawValue)
        ballistaSceneTL = SCNScene(named: ScenePaths.ballistaTLScene.rawValue)
        
        ballistaNodeFL = ballistaSceneFL.rootNode.childNode(withName: BuildingNodes.ballistaFL.rawValue, recursively: true)
        ballistaNodeSL = ballistaSceneSL.rootNode.childNode(withName: BuildingNodes.ballistaSL.rawValue, recursively: true)
        ballistaNodeTL = ballistaSceneTL.rootNode.childNode(withName: BuildingNodes.ballistaTL.rawValue, recursively: true)
    }
    
    static let defaultFactory = BallistaFactory()
    
    func createFirstLevelBuildings() -> AnyBuilding {
        return AnyBuilding(BallistaFL(ballistaNodeFL.clone()))
    }
    
    func createSecondLevelBuildings() -> AnyBuilding {
        return AnyBuilding(BallistaSL(ballistaNodeSL.clone()))
    }
    
    func createThirdLevelBuildings() -> AnyBuilding {
        return AnyBuilding(BallistaSL(ballistaNodeTL.clone()))
    }
}
