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
        createGround(size: size)
        createFence(size: size)
        setupEnemy(size: size)
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
    
    func createGround(size: Int) {
        let ground = output.createGround(size: size)
        for row in ground {
            for cell in row {
                scene.rootNode.addChildNode(cell.scnGroundNode)
            }
        }
    }
    
    func create(_ building: Buildings, On position: SCNVector3) {
        deleteTowerSelectionPanel()
        let building = output.create(building, On: position)
        scene.rootNode.addChildNode(building)
    }
    
    func showTowerSelectionPanel(position: SCNVector3) {
        deleteTowerSelectionPanel()
        let towerSelectionPanel = output.getTowerSelectionPanel(position: position)
        scene.rootNode.addChildNode(towerSelectionPanel)
    }
    
    func createFence(size: Int) {
        let fence = output.createFence(size: size)
        for fenceCell in fence {
            scene.rootNode.addChildNode(fenceCell.scnFenceCellNode)
        }
    }
    
    func setupEnemy(size: Int) {
        let enemy = output.getEnemy(size: size)
        scene.rootNode.addChildNode(enemy.scnEnemyNode)
    }
    
    func deleteTowerSelectionPanel() {
        scene.rootNode.childNode(withName: "towerSelectionPanel", recursively: true)?.removeFromParentNode()
    }
    
    @objc func groundCellTapped (recognizer:UITapGestureRecognizer) {
        let location = recognizer.location(in: sceneView)
        
        let hitResults = sceneView.hitTest(location, options: nil)
        
        if hitResults.count > 0 {
            let result = hitResults.first
            if let node = result?.node {
                if node.name == "groundCell" {
                    showTowerSelectionPanel(position: node.position)
                }
                if node.name == "floor" {
                    deleteTowerSelectionPanel()
                }
                if node.name == "selectedElphTower" {
                    create(.elphTower, On: node.parent!.position)
                }
                if node.name == "selectedMagicTower" {
                    create(.magicTower, On: node.parent!.position)
                }
            }
        }
    }
    
    
}

