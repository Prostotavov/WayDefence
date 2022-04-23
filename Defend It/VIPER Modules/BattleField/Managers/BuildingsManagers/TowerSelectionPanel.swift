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
    func show(for building: Building) -> SCNNode
}

class TowerSelectionPanelImpl: TowerSelectionPanel {
    
    var panelScene: SCNScene!
    var panelNode: SCNNode!
    var boardNode: SCNNode!
    
    let boardWidth: CGFloat = 1
    let boardHeight: CGFloat = 1
    let boardLength: CGFloat = 0.01
    
    let flagWidth: CGFloat = 0.05
    let flagHeight: CGFloat = 0.4
    
    let distanceFromGround: CGFloat = 1.3
    
    init() {
        setupScene()
        setupNode()
        setupPanel()
    }
    
    func createIconFor(_ icon: BuildingIcons) -> SCNNode {
        let planeNode = SCNNode()
        let plane = SCNPlane(width: 0.5, height: 0.5)
        plane.cornerRadius = 1
        planeNode.geometry = plane
        
        let planeMaterial = SCNMaterial()
        
        planeMaterial.diffuse.contents = UIImage(named: icon.rawValue)
        plane.materials = [planeMaterial]
        planeNode.name = icon.rawValue
        
        planeNode.position = SCNVector3(0, 0, 0)
        
        return planeNode
    }
    
    func show(on position: SCNVector3) -> SCNNode {
        panelNode.position = position
        boardNode.childNodes.map{$0.removeFromParentNode()}
        addDefaultTowersToBoard()
        return panelNode
    }
    
    func show(for building: Building) -> SCNNode {
        boardNode.childNodes.map{$0.removeFromParentNode()}
        panelNode.position = building.buildingNode.position
        addIconToBoard(for: building)
        return panelNode
    }
    
    func setupPanel() {
        addFlag()
        addBoard()
        setupConstraints()
    }
    
    func addBoard() {
        boardNode = SCNNode()
        boardNode.position = SCNVector3(0, 1.3, 0)
        panelNode.addChildNode(boardNode)
    }
    
    func addFlag() {
        let flagNode = SCNNode()
        flagNode.geometry = SCNBox(width: flagWidth, height: flagHeight, length: boardLength, chamferRadius: 0)
        flagNode.position = SCNVector3(0, 0.2, 0)
        panelNode.addChildNode(flagNode)
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
    //        ——————————————————————    3 - sellTowerButton, 7 - repairTowerButton
    
    
    // this function is called when the player wants to build a tower on empty groundSquare
    // default locations 0, 2, 4, 6
    func addDefaultTowersToBoard() {
        add(.elphTowerSelectIcon, to: .upLeftPlace)       // 0
        add(.magicTowerSelectIcon, to: .upRightPlace)     // 2
        add(.wallSelectIcon, to: .downLeftPlace)          // 4
        add(.ballistaSelectIcon, to: .downRightPlace)     // 6
    }
    
    func addIconToBoard(for building: Building) {
        add(.repairSelectIcon, to: .repairTowerButton)
        add(.sellSelectIcon, to: .sellTowerButton)
        add(building.upgradeSelection[0], to: .upMiddlePlace)
    }
    
    func getPositionFor(_ place: BuildingIconPlaces) -> SCNVector3 {
        switch place {
        case .upLeftPlace:
            return SCNVector3(-boardWidth/3, boardWidth/3, boardWidth/3)
        case .upMiddlePlace:
            return SCNVector3(0, boardWidth/3, boardWidth/3)
        case .upRightPlace:
            return SCNVector3(boardWidth/3, boardWidth/3, boardWidth/3)
        case .sellTowerButton:
            return SCNVector3(-boardWidth/2, -boardWidth/3, boardWidth/3)
        case .downLeftPlace:
            return SCNVector3(-boardWidth/3, -boardWidth/3, boardWidth/3)
        case .downMiddlePlace:
            return SCNVector3(0, -boardWidth/3, boardWidth/3)
        case .downRightPlace:
            return SCNVector3(boardWidth/3, -boardWidth/3, boardWidth/3)
        case .repairTowerButton:
            return SCNVector3(boardWidth/2, -boardWidth/3, boardWidth/3)
        }
    }
    
    func add(_ icon: BuildingIcons, to place: BuildingIconPlaces) {
        let node = createIconFor(icon)
        node.position = getPositionFor(place)
        boardNode.addChildNode(node)
    }
    
}
