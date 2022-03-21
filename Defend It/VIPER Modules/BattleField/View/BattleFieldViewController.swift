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
        setupEnemy()
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
    
    func build(_ building: Buildings, On position: SCNVector3) {
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
    
    func setupEnemy() {
        let enemy = output.getEnemy()
        scene.rootNode.addChildNode(enemy.scnEnemyNode)
    }
    
    func hideTowerSelectionPanel() {
        scene.rootNode.childNode(withName: "towerSelectionPanel", recursively: true)?.removeFromParentNode()
    }
    
    func run() {
        output.run()
    }
    
    @objc func groundCellTapped (recognizer:UITapGestureRecognizer) {
        let location = recognizer.location(in: sceneView)
        
        let hitResults = sceneView.hitTest(location, options: nil)
        
        if hitResults.count > 0 {
            let result = hitResults.first
            if let node = result?.node {
                if node.name == "groundCell" {
                    showTowerSelectionPanel(On: node.position)
                }
                if node.name == "floor" {
                    hideTowerSelectionPanel()
                }
                if node.name == "selectedElphTower" {
                    build(.elphTower, On: node.parent!.position)
                }
                if node.name == "selectedMagicTower" {
                    build(.magicTower, On: node.parent!.position)
                }
                if node.name == "enemy" {
                    run()
                }
            }
        }
    }
    
    
}

