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
    
    let size: Int = 7
    
    var sceneView: SCNView!
    var scene: SCNScene!
    
    override func loadView() {
        super.loadView()
        assembler.assembly(with: self)
        setupScene()
        setupCamera()
        createGround()
        //        createFence(size: size)
        setupEnemies()
    }
    
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
        let cameraNode = output.setupCamera()
        scene.rootNode.addChildNode(cameraNode)
    }
    
    func createGround() {
        let ground = output.createGround()
        for row in ground {
            for cell in row {
                scene.rootNode.addChildNode(cell.scnGroundNode)
            }
        }
    }
    
    func build(_ building: BuildingTypes, On position: SCNVector3) {
        hideTowerSelectionPanel()
        let building = output.build(building, On: position)
        scene.rootNode.addChildNode(building)
    }
    
    func showTowerSelectionPanel(On position: SCNVector3) {
        hideTowerSelectionPanel()
        let towerSelectionPanel = output.showTowerSelectionPanel(On: position)
        scene.rootNode.addChildNode(towerSelectionPanel)
    }
    
    func createFence() {
        let fence = output.createFence()
        for fenceCell in fence {
            scene.rootNode.addChildNode(fenceCell.scnFenceCellNode)
        }
    }
    
    func setupEnemies() {
        for enemy in output.getEnemies() {
            scene.rootNode.addChildNode(enemy.enemyNode)
        }
    }
    
    func hideTowerSelectionPanel() {
        scene.rootNode.childNode(withName: NodeNames.buildingSelectionPanel.rawValue, recursively: true)?.removeFromParentNode()
    }
    
    func runEnemies() {
        output.runEnemies()
    }
    
    func deleteBuilding(with name: String) {
        output.deleteBuilding(with: name)
        scene.rootNode.childNode(withName: name, recursively: true)?.removeFromParentNode()
    }
    
    func deleteBuilding(with coordinate: (Int, Int)) {
        let name = output.getBuildingName(with: coordinate)
        deleteBuilding(with: name)
        hideTowerSelectionPanel()
    }
    
    func showTowerSelectionPanel(for buildingName: String ) {
        hideTowerSelectionPanel()
        let towerSelectionPanel = output.showTowerSelectionPanel(for: buildingName)
        scene.rootNode.addChildNode(towerSelectionPanel)
    }
    
    @objc func groundCellTapped (recognizer:UITapGestureRecognizer) {
        let location = recognizer.location(in: sceneView)
        let hitResults = sceneView.hitTest(location, options: nil)
        guard let node = hitResults.first?.node else {return}

        switch node.name {
            
        case _ where node.name! == RecognitionNodes.cellSelectionIcon.rawValue:
            deleteBuilding(with:Converter.toCoordinate(from: node.parent!.parent!.position))
        case _ where node.name!.contains(RecognitionNodes.floor.rawValue):
            hideTowerSelectionPanel()
        case _ where node.name!.contains(RecognitionNodes.groundCell.rawValue):
            showTowerSelectionPanel(On: node.parent!.position)
        case _ where node.name!.contains(RecognitionNodes.selectionIcon.rawValue):
            guard let buildingType = Converter.toBuildingType(from: node.name!) else {return}
            build(buildingType, On: node.parent!.parent!.position)
        case _ where node.name!.contains(RecognitionNodes.builtTower.rawValue):
            print(Converter.toBuilding(from: node.parent!.name!))
            showTowerSelectionPanel(for: node.parent!.name!)
        case .none:
            break
        case .some(_):
            runEnemies()
            break
        }
    }
}

enum RecognitionNodes: String  {
    case floor = "floor"
    case groundCell = "groundCell"
    case selectionIcon = "SelectionIcon"
    case builtTower = "builtTower"
    case cellSelectionIcon = "cellSelectionIcon"
    case repairSelectionIcon = "repairSelectionIcon"
}

