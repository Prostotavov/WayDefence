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

    override func loadView() {
        super.loadView()
        assembler.assembly(with: self)
        setupScene()
        initNodes()
        createGround(size: 7)
        
    }
    
    func setupScene() {
        sceneView = SCNView(frame: view.frame)
        scene = SCNScene(named: "art.scnassets/battleField.scn")!
        sceneView.scene = scene
        sceneView.allowsCameraControl = true
        view.addSubview(sceneView)
    }
    
    func initNodes() {
        allElementsScene = SCNScene(named: "art.scnassets/allElements.scn")!
        lightGround = allElementsScene.rootNode.childNode(withName: "lightGround", recursively: true)!
        darkGround = allElementsScene.rootNode.childNode(withName: "darkGround", recursively: true)!
        elphTower = allElementsScene.rootNode.childNode(withName: "elphTower", recursively: true)!
        magicTower = allElementsScene.rootNode.childNode(withName: "magicTower", recursively: true)!

    }
    
    func createGround(size: Int) {
        
        for i in 0..<size {
            
            
            
            
            
            
            
//            ground.append(groundCell)
            
        }
        
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
    

    
}

