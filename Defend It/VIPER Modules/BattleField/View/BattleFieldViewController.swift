// 
//  BattleFieldViewController.swift
//  Defend It
//
//  Created by MacBook Pro on 16.03.22.
//

import UIKit
import SceneKit
import SpriteKit

class BattleFieldViewController: UIViewController, BattleFieldViewInput {
    
    var output: BattleFieldViewOutput!
    var assembler: BattleFieldAssemblyProtocol = BattleFieldAssembly()
    
    var sceneView: SCNView!
    var scene: SCNScene!
    
    var topBarView: TopBarView!
    var bottomBarView: BottomBarView!
    
    override func loadView() {
        super.loadView()
        assembler.assembly(with: self)
        setupScene()
        output.loadView()
        scene.physicsWorld.contactDelegate = self
        sceneView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setupTopBarView()
        setupBottomBarView()
        runRender()
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
    
    func remove(_ node: SCNNode) {
        node.removeFromParentNode()
    }
    
    func removeNode(with name: String) {
        scene.rootNode.childNode(withName: name, recursively: true)?.removeFromParentNode()
    }
    
    func pressed(_ node: SCNNode) {
        output.pressed(node)
    }
    
}

// cameras
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

// physics
extension BattleFieldViewController: SCNPhysicsContactDelegate {
    func physicsWorld(_ world: SCNPhysicsWorld,
                      didBegin contact: SCNPhysicsContact) {
        var collisionEnemyNode: SCNNode!
        var collisionTowerNode: SCNNode!
        
        if contact.nodeA.physicsBody?.categoryBitMask == 1 {
            collisionTowerNode = contact.nodeA
            collisionEnemyNode = contact.nodeB
        } else {
            collisionEnemyNode = contact.nodeA
            collisionTowerNode = contact.nodeB
        }
        output.didBegin(collisionEnemyNode, contactWith: collisionTowerNode)
    }
    
    func physicsWorld(_ world: SCNPhysicsWorld, didEnd contact: SCNPhysicsContact) {
        var collisionEnemyNode: SCNNode!
        var collisionTowerNode: SCNNode!
        
        
        if contact.nodeA.physicsBody?.categoryBitMask == 1 {
            collisionTowerNode = contact.nodeA
            collisionEnemyNode = contact.nodeB
        } else {
            collisionEnemyNode = contact.nodeA
            collisionTowerNode = contact.nodeB
        }
        output.didEnd(collisionEnemyNode, contactWith: collisionTowerNode)
    }
}


// render & actions
extension BattleFieldViewController: SCNSceneRendererDelegate {
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        output.newFrameDidRender()
    }
    
    func runRender() {
        sceneView.isPlaying = true
    }
}

extension BattleFieldViewController {
    
    func setupTopBarView() {
        topBarView = TopBarView(frame: view.frame)
        view.addSubview(topBarView)
        topBarView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topBarView.topAnchor.constraint(equalTo: view.topAnchor),
            topBarView.bottomAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            topBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}


extension BattleFieldViewController {
    
    func setupBottomBarView() {
        bottomBarView = BottomBarView(frame: view.frame)
        view.addSubview(bottomBarView)
        bottomBarView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bottomBarView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bottomBarView.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -90),
            bottomBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}
