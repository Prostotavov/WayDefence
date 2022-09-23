//
//  BattleFieldInteractor.swift
//  Defend It
//
//  Created by MacBook Pro on 16.03.22.
//

import Foundation
import SceneKit

class BattleFieldInteractor: BattleFieldInteractorInput {
        
    weak var output: BattleFieldInteractorOutput!
    var mainCamera: SceneCamera!
    
    var battle: Battle!
    
    func loadView() {
        battle.output = self
        battle.startBattle()
        setupCamera()
    }
    
    func battleSpeedChanged(into newSpeed: Int) {
        output.battleSpeedChanged(into: newSpeed)
    }
    
    func speedButtonPressed() {
        battle.changeBattleSpeed()
    }
    
    func playGame() {
        battle.playBattle()
    }
    
    func stopGame() {
        battle.stopBattle()
    }
    
    func viewDidAppear() {
        battle.displayBattleValues()
        displayBuildingCards()
    }
    
    func displayValues(of valueType: EconomicBattleValueTypes, to number: Int) {
        output.displayValue(of: valueType, to: number)
    }
    
    func getBuildingCards() -> [BuildingCard] {
        battle.getBuildingCards()
    }
    
    func displayBuildingCards() {
        output.displayBuildingCards(getBuildingCards())
    }
}

// funcs for nodes collisions
extension BattleFieldInteractor {
    func didBegin(_ nodeA: SCNNode, contactWith nodeB: SCNNode) {
        battle.didBegin(nodeA, contactWith: nodeB)
    }
    
    func didEnd(_ nodeA: SCNNode, contactWith nodeB: SCNNode) {
        battle.didEnd(nodeA, contactWith: nodeB)
    }
    
    func update() {
        battle.update()
        mainCamera.update()
    }
}


// funcs for setup camera
extension BattleFieldInteractor {
    func setupCamera() {
        mainCamera = SceneCamera()
        mainCamera.initialPosition = SCNVector3(x: 27, y: 30, z: 27)
        mainCamera.initialScale = 2
        mainCamera.initialEulerAngles = SceneCameraConverter.toRadiansFrom(degrees: SCNVector3(x: -40, y: 45, z: 0))
        output.addNodeToScene(mainCamera)
        output.setupPointOfView(from: mainCamera.childNode)
    }
    
    func doubleTapOccurred() {
        mainCamera.handleDoubleTap()
    }
    
    func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        mainCamera.touchesBegan(touches, with: event)
    }
    
    func panGestureOccurred(recognizer: UIPanGestureRecognizer, view: inout UIView) {
        mainCamera.handlePanGesture(recognizer: recognizer, view: &view)
        battle.panGestureOccurred()
    }
    
    func pinchGestureOccurred(recognizer: UIPinchGestureRecognizer, view: inout UIView) {
        mainCamera.handlePinchGesture(recognizer: recognizer, view: &view)
    }
    
    func activateCamera() {
        mainCamera.isActive = true
    }
    
    func inactivateCamera() {
        mainCamera.isActive = false
    }
}


// funs for building by pan a BuildingCard on BattleFieldView
extension BattleFieldInteractor {
    func showBuilding(_ card: BuildingCard, on position: SCNVector3) -> Bool {
        battle.showBuilding(card, on: position)
    }
    
    func pan(_ buildingCard: BuildingCard, by position: SCNVector3) {
        battle.pan(buildingCard, by: position)
    }
    
    func buildTower(with type: BuildingTypes, by coordinate: (Int, Int)) {
        battle.buildTower(type: type, by: coordinate)
    }
}

// user interact nodes
extension BattleFieldInteractor: BattleDelegate {
    func pressedNode(_ node: SCNNode) {
        battle.recognizePressedNode(node)
    }
    
    func addNodeToScene(_ node: SCNNode) {
        output.addNodeToScene(node)
    }
    
    func removeNodeFromScene(with name: String) {
        output.removeNodeFromScene(with: name)
    }
}

extension BattleFieldInteractor: BattleOutput {
    func finishBattle() {
        output.finishBattle()
    }
    func battleIsWon() {
        output.battleIsWon()
    }
    func battleIsLost() {
        output.battleIsLost()
    }
}
