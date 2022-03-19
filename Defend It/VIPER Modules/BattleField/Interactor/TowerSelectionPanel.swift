//
//  TowerSelectionPanel.swift
//  Defend It
//
//  Created by MacBook Pro on 19.03.22.
//

import Foundation
import SceneKit

protocol TowerSelectionPanel {
    func createTowerSelectionPanel(position: SCNVector3) -> SCNNode
}

class TowerSelectionPanelImpl: TowerSelectionPanel {
    
    func createTowerSelectionPanel(position: SCNVector3) -> SCNNode {
        let allElementsScene = SCNScene(named: "art.scnassets/allElements.scn")!
        let scnNode = allElementsScene.rootNode.childNode(withName: "towerSelectionPanel", recursively: true)!
        let billboardConstraint = SCNBillboardConstraint()
        billboardConstraint.freeAxes = .all
        scnNode.constraints = [billboardConstraint]
        scnNode.position = position
        return scnNode
    }
}
