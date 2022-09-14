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
    
    // flow coordinator
    var onPauseBattle: (() -> Void)?
    var onFinishBattle: (() -> Void)?
    var onWinBattle: (() -> Void)?
    var onLoseBattle: (() -> Void)?
    
    // viper
    var output: BattleFieldViewOutput!
    var assembler: BattleFieldAssemblyProtocol = BattleFieldAssembly()
    
    // main views
    var sceneView: SCNView!
    var scene: SCNScene!
    
    // subViews
    var topBarView: TopBarView!
    var towersPanelView: TowersPanelView!
    let towersPanelViewHeight: CGFloat = 70
    var towersPanelViewSpace: CGFloat!
    
    // gestures
    let panGesture = UIPanGestureRecognizer()
    let tapRecognizer = UITapGestureRecognizer()
    
    // vars for handle pan BuildingCard
    var isBuildingShows: Bool = false
    var isBuildingCardPicked: Bool = false
    var shownTowerNode: SCNNode?
    var buildingCardView: TowerCardView?
    var chosenBuildingCell: TowerCardCell?
    
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
        setupTowersPanelView()
        output.viewDidAppear()
        runRender()
        towersPanelViewSpace = view.frame.height - towersPanelViewHeight
    }
    
    func setupScene() {
        self.view = SCNView()
        scene = SCNScene(named: ScenePaths.battleField.rawValue)!
        sceneView = self.view as? SCNView
        sceneView.scene = scene
        sceneView.autoenablesDefaultLighting = true
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
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
}

//MARK: cameras
extension BattleFieldViewController {
    func setupPointOfView(from cameraNode: SCNNode) {
        sceneView.pointOfView = cameraNode
    }
}

//MARK: physics
extension BattleFieldViewController: SCNPhysicsContactDelegate {
    func physicsWorld(_ world: SCNPhysicsWorld, didBegin contact: SCNPhysicsContact) {
        output.didBegin(contact.nodeA, contactWith: contact.nodeB)
    }
    
    func physicsWorld(_ world: SCNPhysicsWorld, didEnd contact: SCNPhysicsContact) {
        output.didEnd(contact.nodeA, contactWith: contact.nodeB)
    }
}


//MARK: render & actions
extension BattleFieldViewController: SCNSceneRendererDelegate {
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        output.update()
    }
    
    func runRender() {
        sceneView.isPlaying = true
    }
}

//MARK: setup topBarView
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

//MARK: setup towersPanelView
extension BattleFieldViewController {
    func setupTowersPanelView() {
        towersPanelView = TowersPanelView(frame: .zero)
        view.addSubview(towersPanelView)
        towersPanelView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            towersPanelView.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -towersPanelViewHeight),
            towersPanelView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            towersPanelView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            towersPanelView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func displayBuildingCards(_ buildingCards: [BuildingCard]) {
        towersPanelView.displayBuildingCards(buildingCards)
    }
}

// MARK: handle buttons
extension BattleFieldViewController: TopBarViewDelegate {
    func pauseButtonPressed() {
        output.onPauseTap()
    }
    
    func speedButtonPressed() {
        output.speedButtonPressed()
    }
    
    func battleSpeedChanged(into newSpeed: Int) {
        topBarView.battleSpeedChanged(into: newSpeed)
    }
}



//MARK: add gestures
extension BattleFieldViewController: UIGestureRecognizerDelegate {
    func addGestureRecognizers() {
        addPanGestureRecognizer()
        addPinchGestureRecognizer()
        addDoubleTapGestureRecognizer()
        addSingleTapGestoreRecognizer()
    }
    
    func addSingleTapGestoreRecognizer() {
        tapRecognizer.numberOfTapsRequired = 1
        tapRecognizer.numberOfTouchesRequired = 1
        tapRecognizer.addTarget(self, action: #selector(tapHandler))
        self.view.addGestureRecognizer(tapRecognizer)
    }
    
    func addDoubleTapGestureRecognizer() {
        let doubleTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap))
        doubleTap.numberOfTapsRequired = 2
        doubleTap.delaysTouchesEnded = false
        self.view.addGestureRecognizer(doubleTap)
    }
    
    func addPinchGestureRecognizer() {
        let pinchGesture = UIPinchGestureRecognizer()
        pinchGesture.addTarget(self, action: #selector(handlePinchGesture(recognizer:)))
        self.view!.addGestureRecognizer(pinchGesture)
    }
    
    func addPanGestureRecognizer() {
        panGesture.addTarget(self, action: #selector(handlePanGesture(recognizer:)))
        panGesture.delegate = self
        self.view!.addGestureRecognizer(panGesture)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        output.touchesBegan(touches, with: event)
    }
    
}

//MARK: handle gestures
extension BattleFieldViewController {
    
    @objc func tapHandler(recognizer:UITapGestureRecognizer) {
        let location = recognizer.location(in: sceneView)
        // if touch in towersPanelView
        if location.y > towersPanelViewSpace {return}
        let hitResults = sceneView.hitTest(location, options: nil)
        guard let node = hitResults.first?.node else {return}
        pressedNode(node)
    }
    
    @objc func handleDoubleTap() {
        output.doubleTapOccurred()
    }
    
    @objc func handlePinchGesture(recognizer: UIPinchGestureRecognizer) {
        output.pinchGestureOccurred(recognizer: recognizer, view: &self.view)
    }

    @objc func handlePanGesture(recognizer: UIPanGestureRecognizer) {
        output.panGestureOccurred(recognizer: recognizer, view: &self.view)
        
        // we need two touch locations
        let sceneViewLocation = recognizer.location(in: sceneView)
        let towersPanelViewLocation = recognizer.location(in: towersPanelView)
        
        // touch in towersPanelView
        if sceneViewLocation.y > towersPanelViewSpace {
            buildingCardView?.isHidden = false
            shownTowerNode?.isHidden = true
            isBuildingShows = false
        } else {
            buildingCardView?.isHidden = true
            shownTowerNode?.isHidden = false
        }
        
        // touch above towersPanelView
        if sceneViewLocation.y < towersPanelViewSpace {
            
            // coordinate of touch in scene
            let hitResults = sceneView.hitTest(sceneViewLocation, options: nil)
            guard let hitPosition = hitResults.first?.worldCoordinates else {return}
            
            // show building
            if !isBuildingShows && isBuildingCardPicked {
                guard let buildingInfo = chosenBuildingCell?.buildingCard?.info else {return}
                showBuilding(buildingInfo.type, with: buildingInfo.level, on: hitPosition)
                buildingCardView?.isHidden = true
                isBuildingShows = true
            }
            
            // pan building by scene
            if isBuildingShows {
                guard let shownTowerNode = shownTowerNode else {return}
                pan(towerNode: shownTowerNode, by: hitPosition)
            }
        }
        
        
        switch recognizer.state {
        case .began:
            // pick a cell
            guard let cardCell = towersPanelView.cellForItem(at: towersPanelViewLocation) else {return}
            cardCell.isHidden = true
            chosenBuildingCell = cardCell
            guard let cardViewFrame = cardCell.towerCardView?.frame else {return}
            
            // create new view. This view we can move around the all sceneView
            buildingCardView = TowerCardView(frame: cardViewFrame)
            guard let imageName = cardCell.buildingCard?.info.upgradeSelection.first?.rawValue else {return}
            guard let costInt = cardCell.buildingCard?.parameter.buildingCost else {return}
            let costSting = String(costInt)
            buildingCardView?.configure(image: imageName, text: costSting)
            self.sceneView.addSubview(buildingCardView!)
            buildingCardView!.center = sceneViewLocation
            
            // inactive camera because we need to pan a view
            output.inactivateCamera()
            // tell that card was picked
            isBuildingCardPicked = true
            
        case .changed:
            // move card
            guard let buildingCardView = buildingCardView else {return}
            buildingCardView.center = sceneViewLocation
            
        case .ended:
            // show cell
            chosenBuildingCell?.isHidden = false
            // remove temp buildingCardView
            buildingCardView?.removeFromSuperview()
            // activate camera
            output.activateCamera()
            
            // builing tower if building was shown
            if isBuildingShows {buildTower()}
            
            // remove fictional buildigNode which we used to show
            shownTowerNode?.removeFromParentNode()
            shownTowerNode = nil
            
            // reset bool vars
            isBuildingShows = false
            isBuildingCardPicked = false
            
        default:
            // show cell
            chosenBuildingCell?.isHidden = false
            // remove temp buildingCardView
            buildingCardView?.removeFromSuperview()
            // activate camera
            output.activateCamera()
            
            // builing tower if building was shown
            if isBuildingShows {buildTower()}
            
            // remove fictional buildigNode which we used to show
            shownTowerNode?.removeFromParentNode()
            shownTowerNode = nil
            
            // reset bool vars
            isBuildingShows = false
            isBuildingCardPicked = false
        }
    }
}

//MARK: func for building by pan a BuildlingCard
extension BattleFieldViewController {
    func buildTower() {
        guard let shownTowerNode = shownTowerNode else {return}
        let coordinate = Converter.toCoordinate(from: shownTowerNode.position)
        guard let buildingInfo = chosenBuildingCell?.buildingCard?.info else {return}
        output.buildTower(with: buildingInfo.type, by: coordinate)
    }
    
    // create fictional tower and adding in the scene. Write this node to shownTowerNode
    // if shownTowerNode is exist, then we need to show this tower
    func showBuilding(_ type: BuildingTypes, with level: BuildingLevels, on position: SCNVector3) {
        if shownTowerNode == nil {
            output.showBuilding(type, with: level, on: position)
            shownTowerNode = scene.rootNode.childNode(withName: "shownTower", recursively: true)
            return
        }
        shownTowerNode?.isHidden = true
    }
    
    // move buildingNode
    func pan(towerNode: SCNNode, by position: SCNVector3) {
        output.pan(towerNode: towerNode, by: position)
    }
}
