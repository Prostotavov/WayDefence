// 
//  BattleFieldViewController.swift
//  Defend It
//
//  Created by MacBook Pro on 16.03.22.
//

import UIKit
import SceneKit

class BattleFieldViewController: UIViewController, BattleFieldViewInput {
    
    var output: BattleFieldViewOutput!
    var assembler: BattleFieldAssemblyProtocol = BattleFieldAssembly()
    
    var sceneView: SCNView!
    var scene: SCNScene!
    
    override func loadView() {
        super.loadView()
        assembler.assembly(with: self)
        setupScene()
        setupCamera()
        setupGround()
        setupEnemies()
    }
    
    func showTowerSelectionPanel(on position: SCNVector3) {
        hideTowerSelectionPanel()
        let towerSelectionPanel = output.showTowerSelectionPanel(On: position)
        scene.rootNode.addChildNode(towerSelectionPanel)
    }
    
    func showTowerSelectionPanel(for buildingName: String ) {
        hideTowerSelectionPanel()
        let towerSelectionPanel = output.showTowerSelectionPanel(for: buildingName)
        scene.rootNode.addChildNode(towerSelectionPanel)
    }
    
    func hideTowerSelectionPanel() {
        scene.rootNode.childNode(withName: NodeNames.buildingSelectionPanel.rawValue, recursively: true)?.removeFromParentNode()
    }
}

// pressed functions
extension BattleFieldViewController {
    
    func enemyPressed() {
        output.enemyPressed()
    }
    
    func sellIconPressed(with coordinate: (Int, Int)) {
        let name = output.getBuildingName(with: coordinate)
        output.sellIconPressed(for: name)
        scene.rootNode.childNode(withName: name, recursively: true)?.removeFromParentNode()
        hideTowerSelectionPanel()
    }
    
    func floorPressed() {
        hideTowerSelectionPanel()
    }
    
    func groundSquarePressed(on position: SCNVector3) {
        showTowerSelectionPanel(on: position)
    }
    
    func buildingIconPressed(with name: String, and position: SCNVector3) {
        hideTowerSelectionPanel()
        guard let buildingType = Converter.toBuildingType(from: name) else {return}
        let building = output.buildingIconPressed(buildingType, On: position)
        scene.rootNode.addChildNode(building)
    }
    
    func builtTowerPressed(with name: String) {
        showTowerSelectionPanel(for: name)
    }
    
    @objc func groundCellTapped (recognizer:UITapGestureRecognizer) {
        let location = recognizer.location(in: sceneView)
        let hitResults = sceneView.hitTest(location, options: nil)
        guard let node = hitResults.first?.node else {return}

        switch node.name {
            
        case _ where node.name! == RecognitionNodes.sellSelectionIcon.rawValue:
            sellIconPressed(with:Converter.toCoordinate(from: node.parent!.parent!.position))

        case _ where node.name!.contains(RecognitionNodes.floor.rawValue):
            floorPressed()
            
        case _ where node.name!.contains(RecognitionNodes.groundSquare.rawValue):
            groundSquarePressed(on: node.parent!.position)
            
        case _ where node.name!.contains(RecognitionNodes.selectionIcon.rawValue):
            buildingIconPressed(with: node.name!, and: node.parent!.parent!.position)
            
        case _ where node.name!.contains(RecognitionNodes.builtTower.rawValue):
            builtTowerPressed(with: node.parent!.name!)
            
        case .none:
            break
        case .some:
            enemyPressed()
            break
        }
    }
}

// for setup functions
extension BattleFieldViewController {
    func setupScene() {
        sceneView = SCNView(frame: view.frame)
        scene = SCNScene(named: "art.scnassets/battleField.scn")!
        sceneView.scene = scene
        sceneView.allowsCameraControl = true
        view.addSubview(sceneView)
        
        let tapRecognizer = UITapGestureRecognizer()
        tapRecognizer.numberOfTapsRequired = 1
        tapRecognizer.numberOfTouchesRequired = 1
        
        tapRecognizer.addTarget(self, action: #selector(groundCellTapped))
        sceneView.addGestureRecognizer(tapRecognizer)
    }
    
    func setupCamera() {
        let cameraNode = output.getCamera()
        scene.rootNode.addChildNode(cameraNode)
    }
    
    func setupGround() {
        let squares = output.getGroundSquares()
        for squareRow in squares {
            for square in squareRow {
                scene.rootNode.addChildNode(square.scnNode)
            }
        }
    }
    
    func setupEnemies() {
        for enemy in output.getEnemies() {
            scene.rootNode.addChildNode(enemy.enemyNode)
        }
    }
}

enum RecognitionNodes: String  {
    case floor = "floor"
    case groundSquare = "groundSquare"
    case selectionIcon = "SelectionIcon"
    case builtTower = "builtTower"
    case sellSelectionIcon = "sellSelectionIcon"
    case repairSelectionIcon = "repairSelectionIcon"
}

