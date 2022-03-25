//
//  TowerSelectionPanel.swift
//  Defend It
//
//  Created by MacBook Pro on 19.03.22.
//

import Foundation
import SceneKit

protocol TowerSelectionPanel {
    func show(on position: SCNVector3) -> SCNNode
}

class TowerSelectionPanelImpl: TowerSelectionPanel {
    
    var panelScene: SCNScene!
    var magicTowerScene: SCNScene!
    var elphTowerScene: SCNScene!
    var panelNode: SCNNode!
    var magicTowerNode: SCNNode!
    var elphTowerNode: SCNNode!

    
    init() {
        setupScenes()
        setupNodes()
    }
    
    func show(on position: SCNVector3) -> SCNNode {
        let allElementsScene = SCNScene(named: ScenePaths.allElements.rawValue)!
        let scnNode = allElementsScene.rootNode.childNode(withName: "towerSelectionPanel", recursively: true)!
        let billboardConstraint = SCNBillboardConstraint()
        billboardConstraint.freeAxes = .all
        scnNode.constraints = [billboardConstraint]
        scnNode.position = position
        return scnNode
    }
    
    private func setupScenes() {
        panelScene = SCNScene(named: ScenePaths.buildingSelectionPanelScene.rawValue)
        magicTowerScene = SCNScene(named: ScenePaths.magicTowerScene.rawValue)
        elphTowerScene = SCNScene(named: ScenePaths.elphTowerScene.rawValue)
    }
    
    private func setupNodes() {
        panelNode = panelScene?.rootNode.childNode(withName: NodeNames.buildingSelectionPanel.rawValue, recursively: true)!
        magicTowerNode = magicTowerScene?.rootNode.childNode(withName: NodeNames.magicTower.rawValue, recursively: true)
        elphTowerNode = magicTowerScene?.rootNode.childNode(withName: NodeNames.elphTower.rawValue, recursively: true)
    }
}
