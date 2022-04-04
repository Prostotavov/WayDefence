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
        
        wallNodeFL = wallSceneFL.rootNode.childNode(withName: NodeNames.wallFL.rawValue, recursively: true)
        wallNodeSL = wallSceneSL.rootNode.childNode(withName: NodeNames.wallSL.rawValue, recursively: true)
        wallNodeTL = wallSceneTL.rootNode.childNode(withName: NodeNames.wallTL.rawValue, recursively: true)
    }
    
    static let defaultFactory = WallFactory()
    
    func createFirstLevelBuildings() -> Building {
        return WallFL(wallNodeFL.clone())
    }
    
    func createSecondLevelBuildings() -> Building {
        return WallSL(wallNodeSL.clone())
    }
    
    func createThirdLevelBuildings() -> Building {
        return WallSL(wallNodeTL.clone())
    }
}
