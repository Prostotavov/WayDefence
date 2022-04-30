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
        output.loadView()
    }
    
    func setupScene() {
        sceneView = SCNView(frame: view.frame)
        scene = SCNScene(named: ScenePaths.battleField.rawValue)!
        sceneView.scene = scene
        sceneView.allowsCameraControl = true
        sceneView.autoenablesDefaultLighting = true
        view.addSubview(sceneView)
        
        let tapRecognizer = UITapGestureRecognizer()
        tapRecognizer.numberOfTapsRequired = 1
        tapRecognizer.numberOfTouchesRequired = 1
        tapRecognizer.addTarget(self, action: #selector(tapHandler))
        sceneView.addGestureRecognizer(tapRecognizer)
    }
    
    @objc func tapHandler (recognizer:UITapGestureRecognizer) {
        let location = recognizer.location(in: sceneView)
        let hitResults = sceneView.hitTest(location, options: nil)
        guard let node = hitResults.first?.node else {return}
        pressed(node)
    }
    
    func add(_ node: SCNNode) {
        scene.rootNode.addChildNode(node)
    }
    
    func removeNode(with name: String) {
        scene.rootNode.childNode(withName: name, recursively: true)?.removeFromParentNode()
    }
    
    func pressed(_ node: SCNNode) {
        output.pressed(node)
    }
    
}

extension BattleFieldViewController {
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        let deviceOrientation = UIDevice.current.orientation
        output.deviceOrientationChanged(to: deviceOrientation)
    }
    
    func setupPointOfView(from cameraNode: SCNNode) {
        sceneView.pointOfView = cameraNode
        
    }
    
    func setViewHorisontalOrientation() {
        if sceneView.frame.height > sceneView.frame.width {
            sceneView.frame = CGRect(x: 0, y: 0, width: sceneView.frame.height, height: sceneView.frame.width)
        }
    }
    
    func setViewVerticalOrientation() {
        if sceneView.frame.height < sceneView.frame.width {
            sceneView.frame = CGRect(x: 0, y: 0, width: sceneView.frame.height, height: sceneView.frame.width)
        }
    }
}


