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
    var allElementsScene: SCNScene!
    var lightGround: SCNNode!
    var darkGround: SCNNode!
    var elphTower: SCNNode!
    var magicTower: SCNNode!
    var ground: [[SCNNode]] = []
    
    var towerSelectionPanel: SCNNode!
    var cameraNode: SCNNode!

    override func loadView() {
        super.loadView()
        assembler.assembly(with: self)
        setupScene()
        initNodes()
        setupCameraAt(position: SCNVector3(x: 1.5, y: 4, z: 1.5))
        createGround(size: 7)
        
        
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
        lightGround = allElementsScene.rootNode.childNode(withName: "lightGround", recursively: true)!
        darkGround = allElementsScene.rootNode.childNode(withName: "darkGround", recursively: true)!
        elphTower = allElementsScene.rootNode.childNode(withName: "elphTower", recursively: true)!
        magicTower = allElementsScene.rootNode.childNode(withName: "magicTower", recursively: true)!
        towerSelectionPanel = allElementsScene.rootNode.childNode(withName: "towerSelectionPanel", recursively: true)!

    }
    
    func createGround(size: Int) {
        for x in 0..<size {
            var row: [SCNNode] = []
            for z in 0..<size {
                let groundCell = SCNNode()
                var geometry: SCNGeometry!
                ((x % 2) != 0 && (z % 2) != 0) || (x % 2) != 1 && (z % 2) != 1 ? (geometry = lightGround.geometry) : (geometry = darkGround.geometry)
                groundCell.geometry = geometry
                groundCell.name = "\(x), \(z)"
                groundCell.position = SCNVector3(Float(x)/2, 0, Float(z)/2)
                scene.rootNode.addChildNode(groundCell)
                row.append(groundCell)
            }
            ground.append(row)
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
    
    
    
    @objc func groundCellTapped (recognizer:UITapGestureRecognizer) {
        let location = recognizer.location(in: sceneView)
        
        let hitResults = sceneView.hitTest(location, options: nil)
        
        if hitResults.count > 0 {
            let result = hitResults.first
            if let node = result?.node {
                if node.geometry == darkGround.geometry ||
                    node.geometry == lightGround.geometry {
                    createTowerSelectionPanelAt(node.position)
                }
                print(node.name)
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

