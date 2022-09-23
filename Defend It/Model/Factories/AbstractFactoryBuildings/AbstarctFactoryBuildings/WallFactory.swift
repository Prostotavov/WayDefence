//
//  WallFactory.swift
//  Defend It
//
//  Created by MacBook Pro on 4.04.22.
//

import SceneKit

class WallFactory: AbstactFactoryBuildings {
    
    private let wallSceneFL: SCNScene!
    private let wallSceneSL: SCNScene!
    private let wallSceneTL: SCNScene!
    
    private let wallNodeFL: SCNNode!
    private let wallNodeSL: SCNNode!
    private let wallNodeTL: SCNNode!
    
    init() {
        wallSceneFL = SCNScene(named: ScenePaths.wallFLScene.rawValue)
        wallSceneSL = SCNScene(named: ScenePaths.wallSLScene.rawValue)
        wallSceneTL = SCNScene(named: ScenePaths.wallTLScene.rawValue)
        
        wallNodeFL = wallSceneFL.rootNode.childNode(withName: BuildingNodes.wallFL.rawValue, recursively: true)
        wallNodeSL = wallSceneSL.rootNode.childNode(withName: BuildingNodes.wallSL.rawValue, recursively: true)
        wallNodeTL = wallSceneTL.rootNode.childNode(withName: BuildingNodes.wallTL.rawValue, recursively: true)
    }
    
    static let defaultFactory = WallFactory()
    
    func createFirstLevelBuildings() -> AnyBuilding {
        return AnyBuilding(WallFL(wallNodeFL.clone()))
    }
    
    func createSecondLevelBuildings() -> AnyBuilding {
        return AnyBuilding(WallSL(wallNodeSL.clone()))
    }
    
    func createThirdLevelBuildings() -> AnyBuilding {
        return AnyBuilding(WallSL(wallNodeTL.clone()))
    }
}
