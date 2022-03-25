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
    var panelNode: SCNNode!
    var boardNode: SCNNode!
    var selectionItems: [SCNNode] = []
    
    let boardWidth: CGFloat = 1
    let boardHeight: CGFloat = 1
    let boardLength: CGFloat = 0.01
    
    let flagWidth: CGFloat = 0.05
    let flagHeight: CGFloat = 0.4
    
    let distanceFromGround: CGFloat = 1.3

    
    init(selectionItems: [SCNNode]) {
        self.selectionItems = selectionItems
        setupScene()
        setupNode()
        setupPanel()
    }
    
    func show(on position: SCNVector3) -> SCNNode {
        panelNode.position = position
        return panelNode
    }
    
    func setupPanel() {
        addFlag()
        addBoard()
        setupConstraints()
    }
    
    func addBoard() {
        boardNode = SCNNode()
        boardNode.geometry = SCNBox(width: boardWidth, height: boardHeight, length: boardLength, chamferRadius: 0)
        boardNode.position = SCNVector3(0, 1.3, 0)
        addDefaultTowersToBoard(selectionItems: selectionItems)
        panelNode.addChildNode(boardNode)
    }
    
    func addFlag() {
        let flagNode = SCNNode()
        flagNode.geometry = SCNBox(width: flagWidth, height: flagHeight, length: boardLength, chamferRadius: 0)
        flagNode.position = SCNVector3(0, 0.2, 0)
        panelNode.addChildNode(flagNode)
    }
    
    func addToBoard() {

    }
    
    func setupConstraints() {
        let billboardConstraint = SCNBillboardConstraint()
        billboardConstraint.freeAxes = .all
        panelNode.constraints = [billboardConstraint]
    }
    
    private func setupScene() {
        panelScene = SCNScene(named: ScenePaths.buildingSelectionPanelScene.rawValue)
    }
    
    private func setupNode() {
        panelNode = panelScene?.rootNode.childNode(withName: NodeNames.buildingSelectionPanel.rawValue, recursively: true)!
    }
}

extension TowerSelectionPanelImpl {
    
    //                board
    //        ——————————————————————
    //       |          |           |
    //       |    0     1     2     |   0 - upLeftPlace, 1 - upMiddlePlace, 2 - upRightPlace
    //       |          |           |
    //        ————————tower——————————
    //       |          |           |
    //       3    4     5     6     7   4 - downLeftPlace, 5 - downMiddlePlace, 6 - downRightPlace
    //       |          |           |
    //        ——————————————————————    3 - deleteTowerButton, 7 - repairTowerButton
    
    
    // this function is called when the player wants to build a tower on empty groundCell
    // default locations 0, 2, 4, 6
    func addDefaultTowersToBoard(selectionItems: [SCNNode]) {
        selectionItems[0].scale = SCNVector3(2, 2, 2)
        selectionItems[0].eulerAngles = SCNVector3(-CGFloat.pi/4, CGFloat.pi, CGFloat.pi/12)
        selectionItems[0].name = "selectedElphTower"
        addToUpLeftPlace(selectionItem: selectionItems[0])          // 0
        addToUpRightPlace(selectionItem: selectionItems[0])         // 2
        addToDownLeftPlace(selectionItem: selectionItems[0])        // 4
        addToDownRightPlace(selectionItem: selectionItems[0])       // 6
    }
    
    // This function is called when the player wants to build, improve, sell or repair a tower
    // location - custom ;)
    func addCustomTowersToBoard(selectionItems: [SCNNode]) {
        
    }
    
    // 0 place
    func addToUpLeftPlace(selectionItem: SCNNode) {
        selectionItem.position = SCNVector3(-boardWidth/4, boardWidth/4, boardWidth/4)
        boardNode.addChildNode(selectionItem.clone())
    }
    
    // 1 place
    func addToUpMiddlePlace(selectionItem: SCNNode) {
        selectionItem.position = SCNVector3(0, boardWidth/4, boardWidth/4)
        boardNode.addChildNode(selectionItem.clone())
    }
    
    // 2 place
    func addToUpRightPlace(selectionItem: SCNNode) {
        selectionItem.position = SCNVector3(boardWidth/4, boardWidth/4, boardWidth/4)
        boardNode.addChildNode(selectionItem.clone())
    }
    
    // 3 place
    func addToDeletePlace(selectionItem: SCNNode) {
        selectionItem.position = SCNVector3(-boardWidth/2, -boardWidth/4, boardWidth/4)
        boardNode.addChildNode(selectionItem.clone())
    }
    
    // 4 place
    func addToDownLeftPlace(selectionItem: SCNNode) {
        selectionItem.position = SCNVector3(-boardWidth/4, -boardWidth/4, boardWidth/4)
        boardNode.addChildNode(selectionItem.clone())
    }
    
    // 5 place
    func addToDownMiddlePlace(selectionItem: SCNNode) {
        selectionItem.position = SCNVector3(0, -boardWidth/4, boardWidth/4)
        boardNode.addChildNode(selectionItem.clone())
    }
    
    // 6 place
    func addToDownRightPlace(selectionItem: SCNNode) {
        selectionItem.position = SCNVector3(boardWidth/4, -boardWidth/4, boardWidth/4)
        boardNode.addChildNode(selectionItem.clone())
    }
    
    // 7 place
    func addToRepairPlace(selectionItem: SCNNode) {
        selectionItem.position = SCNVector3(boardWidth/4, -boardWidth/4, boardWidth/4)
        boardNode.addChildNode(selectionItem.clone())
    }


}
