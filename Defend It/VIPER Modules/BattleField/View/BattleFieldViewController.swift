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
    var allElementsScene: SCNScene!
    var elphTower: SCNNode!
    var magicTower: SCNNode!
    
    override func loadView() {
        super.loadView()
        assembler.assembly(with: self)
        setupScene()
        initNodes()
        setupCamera()
        createGround(size: size)
        createFence(size: size)
        setupEnemy(size: size)
//        showTowerSelectionPanel(position:SCNVector3(2, 1, 2))
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
    
    func initNodes() {
        allElementsScene = SCNScene(named: "art.scnassets/allElements.scn")!
        elphTower = allElementsScene.rootNode.childNode(withName: "elphTower", recursively: true)!
        magicTower = allElementsScene.rootNode.childNode(withName: "magicTower", recursively: true)!
    }
    
    func createGround(size: Int) {
        let ground = output.createGround(size: size)
        for row in ground {
            for cell in row {
                scene.rootNode.addChildNode(cell.scnGroundNode)
            }
        }
        
    }
    
    func create(_ name: String, At position: SCNVector3) {
        var tower: SCNNode!
        (name == "magicTower") ? (tower = magicTower.clone()) : (tower = elphTower.clone())
        tower.position = position
        scene.rootNode.addChildNode(tower)
        scene.rootNode.childNode(withName: "towerSelectionPanel", recursively: true)?.removeFromParentNode()
    }
    
    func showTowerSelectionPanel(position: SCNVector3) {
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
    
    @objc func groundCellTapped (recognizer:UITapGestureRecognizer) {
        let location = recognizer.location(in: sceneView)
        
        let hitResults = sceneView.hitTest(location, options: nil)
        
        if hitResults.count > 0 {
            let result = hitResults.first
            if let node = result?.node {
                if node.name == "magicTower" {
                    create("magicTower", At: node.parent!.position)
                }
                if node.name == "elphTower" {
                    create("elphTower", At: node.parent!.position)
                }
                if node.name == "floor" {
                    scene.rootNode.childNode(withName: "towerSelectionPanel", recursively: true)?.removeFromParentNode()
                }
            }
        }
    }
    
    
}

