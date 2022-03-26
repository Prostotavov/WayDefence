//
//  ElphTowerFactory.swift
//  Defend It
//
//  Created by MacBook Pro on 19.03.22.
//

import SceneKit

class ElphTowerFactory: AbstactFactoryBuildings {
    
    let elphTowerScene: SCNScene!
    let elphTowerNode: SCNNode!
    
    init() {
        elphTowerScene = SCNScene(named: ScenePaths.elphTowerScene.rawValue)
        elphTowerNode = elphTowerScene.rootNode.childNode(withName: NodeNames.elphTower.rawValue, recursively: true)
    }
    
    static let defaultFactory = ElphTowerFactory()
    
    func createFirstLevelBuildings() -> Building {
        return ElphTowerFL(elphTowerNode)
    }
    
    func createSecondLevelBuildings() -> Building {
        return ElphTowerSL(elphTowerNode)
    }
}
