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
    
    var buildings: [Building] = []
    var availableBuildings: [Building] = []
    
    
    var sceneView: SCNView!
    var scene: SCNScene!
    var allElementsScene: SCNScene!
    var elphTower: SCNNode!
    var magicTower: SCNNode!
    var enemy: SCNNode!
    
    
    var towerSelectionPanel: SCNNode!
    var cameraNode: SCNNode!

    override func loadView() {
        super.loadView()
        assembler.assembly(with: self)
        setupScene()
        initNodes()
        setupCameraAt(position: SCNVector3(x: 1.5, y: 4, z: 1.5))
        print("before createGround in init")
        createGround(size: size)
        print("after createGround in init")
        createFence(size: size)
//        createEnemy()
//        setupAvailableBuildings()
    }
    
    func setupAvailableBuildings() {
        allElementsScene = SCNScene(named: "art.scnassets/allElements.scn")!
        
        var magicTower = MagicTowerFactory.defaultFactory.createFirstLevelBuildings()
        let magicTowerNode = allElementsScene.rootNode.childNode(withName: "magicTower", recursively: true)!
        magicTower.scnNode = magicTowerNode
        availableBuildings.append(magicTower)
        
        var elphTower = MagicTowerFactory.defaultFactory.createFirstLevelBuildings()
        let elphTowerNode = allElementsScene.rootNode.childNode(withName: "elphTower", recursively: true)!
        elphTower.scnNode = elphTowerNode
        availableBuildings.append(elphTower)
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
    
    func setupCameraAt(position: SCNVector3) {
        cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = position
//        cameraNode.position = SCNVector3(0, 3, -3)
        let xAngle = Float(-180 * Float(180 / 3.14))
        cameraNode.eulerAngles = SCNVector3Make(xAngle, 0, 0)
        scene.rootNode.addChildNode(cameraNode)
        
    }
    
    func initNodes() {
        allElementsScene = SCNScene(named: "art.scnassets/allElements.scn")!
        elphTower = allElementsScene.rootNode.childNode(withName: "elphTower", recursively: true)!
        magicTower = allElementsScene.rootNode.childNode(withName: "magicTower", recursively: true)!
        towerSelectionPanel = allElementsScene.rootNode.childNode(withName: "towerSelectionPanel", recursively: true)!
        enemy = allElementsScene.rootNode.childNode(withName: "enemy", recursively: true)!
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
    
    func createTowerSelectionPanelAt(_ position: SCNVector3) {
        let billboardConstraint = SCNBillboardConstraint()
        billboardConstraint.freeAxes = .all
        towerSelectionPanel.constraints = [billboardConstraint]
        towerSelectionPanel.position = position
        scene.rootNode.addChildNode(towerSelectionPanel)
    }
    
    func createFence(size: Int) {
        let fence = output.createFence(size: size)
        for fenceCell in fence {
            scene.rootNode.addChildNode(fenceCell.scnFenceCellNode)
        }
    }
    
    func createEnemy() {
        let enemy = enemy.clone()
        enemy.position = SCNVector3(-0.25, 0, CGFloat(size/4)+0.5)
        scene.rootNode.addChildNode(enemy)
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

