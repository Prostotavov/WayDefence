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

class BattleFieldViewController: UIViewController, BattleFieldViewInput,
                                 BattleFieldLoadDelegate, BattleFieldViewCoordinatorOutput {
    
    var onPauseBattle: (() -> Void)?
    var onFinishBattle: (() -> Void)?
    var onWinBattle: (() -> Void)?
    var onLoseBattle: (() -> Void)?
    
    var output: BattleFieldViewOutput!
    var assembler: BattleFieldAssemblyProtocol = BattleFieldAssembly()
    
    var sceneView: SCNView!
    var scene: SCNScene!
    
    var topBarView: TopBarView!
    var bottomBarView: BottomBarView!
    
    override func loadView() {
        setupScene()
        output.loadView()
        scene.physicsWorld.contactDelegate = self
        sceneView.delegate = self
        addGestureRecognizers()
    }
 
    
    
    func assemblyModule(delegate: BattleFieldAssemblyDelagate) {
        assembler.setDelegate(delegate: delegate)
        assembler.assemblyModuleForViewInput(viewInput: self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setupTopBarView()
        setupBottomBarView()
        output.viewDidAppear()
        runRender()
    }
    
    func setupScene() {
        self.view = SCNView()
        scene = SCNScene(named: ScenePaths.battleField.rawValue)!
        sceneView = self.view as? SCNView
        sceneView.scene = scene
        sceneView.autoenablesDefaultLighting = true
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
    func setupPointOfView(from cameraNode: SCNNode) {
        sceneView.pointOfView = cameraNode
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
        topBarView.delegate = self
        view.addSubview(topBarView)
        topBarView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topBarView.topAnchor.constraint(equalTo: view.topAnchor),
            topBarView.bottomAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            topBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func displayValue(of valueType: EconomicBattleValueTypes, to number: Int) {
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

extension BattleFieldViewController: TopBarViewDelegate {
    func pauseButtonPressed() {
        output.onPauseTap()
    }
}

extension BattleFieldViewController: UIGestureRecognizerDelegate {
    func addGestureRecognizers() {
        addPanGestureRecognizer()
        addPinchGestureRecognizer()
        addDoubleTapGestureRecognizer()
        addSingleTapGestoreRecognizer()
    }
    
    func addSingleTapGestoreRecognizer() {
        let tapRecognizer = UITapGestureRecognizer()
        tapRecognizer.numberOfTapsRequired = 1
        tapRecognizer.numberOfTouchesRequired = 1
        tapRecognizer.addTarget(self, action: #selector(tapHandler))
        self.view.addGestureRecognizer(tapRecognizer)
    }
    
    func addDoubleTapGestureRecognizer() {
        let doubleTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap))
        doubleTap.numberOfTapsRequired = 2
        self.view.addGestureRecognizer(doubleTap)
    }
    
    func addPinchGestureRecognizer() {
        let pinchGesture = UIPinchGestureRecognizer()
        pinchGesture.addTarget(self, action: #selector(handlePinchGesture(recognizer:)))
        self.view!.addGestureRecognizer(pinchGesture)
    }
    
    func addPanGestureRecognizer() {
        let panGesture = UIPanGestureRecognizer()
        panGesture.addTarget(self, action: #selector(handlePanGesture(recognizer:)))
        panGesture.delegate = self
        self.view!.addGestureRecognizer(panGesture)
    }
    
    @objc func handleDoubleTap() {
        output.doubleTapOccurred()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        output.touchesBegan(touches, with: event)
    }
    
    @objc func handlePanGesture(recognizer: UIPanGestureRecognizer) {
        output.panGestureOccurred(recognizer: recognizer, view: &self.view)
    }
    
    @objc func handlePinchGesture(recognizer: UIPinchGestureRecognizer) {
        output.pinchGestureOccurred(recognizer: recognizer, view: &self.view)
    }
}
