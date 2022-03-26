//
//  MagicTowerFactory.swift
//  Defend It
//
//  Created by MacBook Pro on 19.03.22.
//

import SceneKit

class MagicTowerFactory: AbstactFactoryBuildings {
    
    let magicTowerScene: SCNScene!
    let magicTowerNode: SCNNode!
    
    init() {
        magicTowerScene = SCNScene(named: ScenePaths.magicTowerScene.rawValue)
        magicTowerNode = magicTowerScene.rootNode.childNode(withName: NodeNames.magicTower.rawValue, recursively: true)
    }
    
    static let defaultFactory = MagicTowerFactory()
    
    func createFirstLevelBuildings() -> Building {
        return MagicTowerFL(magicTowerNode)
    }
    
    func createSecondLevelBuildings() -> Building {
        return MagicTowerSL(magicTowerNode)
    }
}
