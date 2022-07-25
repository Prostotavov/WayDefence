// 
//  BattleFieldViewController.swift
//  Defend It
//
//  Created by MacBook Pro on 16.03.22.
//

import UIKit
import SceneKit
import SpriteKit

protocol BattleFieldLoadDelegate: UIViewController {
    func assemblyModule(delegate: BattleFieldAssemblyDelagate)
}

class BattleFieldViewController: UIViewController, BattleFieldViewInput, BattleFieldLoadDelegate {
    
    var output: BattleFieldViewOutput!
    var assembler: BattleFieldAssemblyProtocol = BattleFieldAssembly()
    
    var sceneView: SCNView!
    var scene: SCNScene!
    
    var topBarView: TopBarView!
    var bottomBarView: BottomBarView!
    
    override func loadView() {
        super.loadView()
        setupScene()
        output.loadView()
        scene.physicsWorld.contactDelegate = self
        sceneView.delegate = self
    }
    
    func assemblyModule(delegate: BattleFieldAssemblyDelagate) {
        assembler.setDelegate(delegate: delegate)
        assembler.assembly(with: self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setupTopBarView()
        setupBottomBarView()
        runRender()
        output.viewDidAppear()
    }
    
    func setupScene() {
        sceneView = SCNView(frame: view.frame)
        scene = SCNScene(named: ScenePaths.battleField.rawValue)!
        sceneView.scene = scene
        sceneView.allowsCameraControl = true
        sceneView.autoenablesDefaultLighting = true
        view.addSubview(sceneView)
        
        let panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panGesture))
        sceneView.addGestureRecognizer(panRecognizer)
        
        let tapRecognizer = UITapGestureRecognizer()
        tapRecognizer.numberOfTapsRequired = 1
        tapRecognizer.numberOfTouchesRequired = 1
        tapRecognizer.addTarget(self, action: #selector(tapHandler))
        sceneView.addGestureRecognizer(tapRecognizer)
    }
    
    @objc func tapHandler(recognizer:UITapGestureRecognizer) {
        let location = recognizer.location(in: sceneView)
        let hitResults = sceneView.hitTest(location, options: nil)
        guard let node = hitResults.first?.node else {return}
        pressedNode(node)
    }
    
    func addNodeToScene(_ node: SCNNode) {
        scene.rootNode.addChildNode(node)
    }
    func removeNodeFromScene(_ node: SCNNode) {
        node.removeFromParentNode()
    }
    func removeNodeFromScene(with name: String) {
        scene.rootNode.childNode(withName: name, recursively: true)?.removeFromParentNode()
    }
    func pressedNode(_ node: SCNNode) {
        output.pressedNode(node)
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
    
    @objc func panGesture(recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .changed:
            let translation = recognizer.translation(in: view)
            output.panGestureChanged(by: translation)
        case .ended:
            output.panGestureEnded()
        default:
            print("default panGesture switch BattleFieldViewController")
        }
    }
}

// physics
extension BattleFieldViewController: SCNPhysicsContactDelegate {
    func physicsWorld(_ world: SCNPhysicsWorld, didBegin contact: SCNPhysicsContact) {
        output.didBegin(contact.nodeA, contactWith: contact.nodeB)
    }
    
    func physicsWorld(_ world: SCNPhysicsWorld, didEnd contact: SCNPhysicsContact) {
        output.didEnd(contact.nodeA, contactWith: contact.nodeB)
    }
}


// render & actions
extension BattleFieldViewController: SCNSceneRendererDelegate {
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        output.update()
    }
    
    func runRender() {
        sceneView.isPlaying = true
    }
}

// topBarView
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
    
    func displayValue(of valueType: BattleValueTypes, to number: Int) {
        topBarView.displayValue(of: valueType, to: number)
    }
}


// bottomBarView
extension BattleFieldViewController: BottomBarViewDelegate {
    func playButtonPressed() {
        output.playButtonPressed()
    }
    
    func stopButtonPressed() {
        output.stopButtonPressed()
    }
    
    func setupBottomBarView() {
        bottomBarView = BottomBarView(frame: view.frame)
        bottomBarView.delegate = self
        view.addSubview(bottomBarView)
        bottomBarView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bottomBarView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bottomBarView.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
            bottomBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

