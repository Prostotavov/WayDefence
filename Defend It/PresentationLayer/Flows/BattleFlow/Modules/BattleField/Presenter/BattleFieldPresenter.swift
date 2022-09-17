// 
//  BattleFieldPresenter.swift
//  Defend It
//
//  Created by MacBook Pro on 16.03.22.
//

import Foundation
import SceneKit

class BattleFieldPresenter: BattleFieldViewOutput, BattleFieldInteractorOutput {

    weak var view: BattleFieldViewInput!
    weak var coordinator: BattleFieldViewCoordinatorOutput!
    var interactor: BattleFieldInteractorInput!
    
    
    /// func for flow coordinator
    func finishBattle() {
        coordinator.onFinishBattle?()
    }
    func battleIsWon() {
        coordinator.onWinBattle?()
    }
    func battleIsLost() {
        coordinator.onLoseBattle?()
    }
    func onPauseTap() {
        interactor.stopGame()
        coordinator.onPauseBattle?()
    }
    
    /// view run loop funcs
    func loadView() {
        interactor.loadView()
    }
    func viewDidAppear() {
        interactor.viewDidAppear()
    }
    
    /// func for scene
    func addNodeToScene(_ node: SCNNode) {
        view.addNodeToScene(node)
    }
    func removeNodeFromScene(_ node: SCNNode) {
        view.removeNodeFromScene(node)
    }
    func removeNodeFromScene(with name: String) {
        view.removeNodeFromScene(with: name)
    }
    
    /// func for device change orientation
    //MARK: Camera
    func setupPointOfView(from cameraNode: SCNNode) {
        view.setupPointOfView(from: cameraNode)
    }
    
    func activateCamera() {
        interactor.activateCamera()
    }
    
    func inactivateCamera() {
        interactor.inactivateCamera()
    }
    
    /// game run loop
    func update() {
        interactor.update()
    }
    
    /// nodes collisions
    func didBegin(_ nodeA: SCNNode, contactWith nodeB: SCNNode) {
        interactor.didBegin(nodeA, contactWith: nodeB)
    }
    func didEnd(_ nodeA: SCNNode, contactWith nodeB: SCNNode) {
        interactor.didEnd(nodeA, contactWith: nodeB)
    }
    
    /// func for display values to the topBarView
    //MARK: Display
    func displayValue(of valueType: EconomicBattleValueTypes, to number: Int) {
        view.displayValue(of: valueType, to: number)
    }
    
    func displayBuildingCards(_ buildingCards: [BuildingCard]) {
        view.displayBuildingCards(buildingCards)
    }
    
    
    /// user can stop and play the game
    //MARK: User Interactions
    func speedButtonPressed() {
        interactor.speedButtonPressed()
    }
    
    func battleSpeedChanged(into newSpeed: Int) {
        view.battleSpeedChanged(into: newSpeed)
    }
    
    /// func for handle pressed node by user
    func pressedNode(_ node: SCNNode) {
        interactor.pressedNode(node)
    }
    
    func doubleTapOccurred() {
        interactor.doubleTapOccurred()
    }
    
    func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        interactor.touchesBegan(touches, with: event)
    }
    
    func panGestureOccurred(recognizer: UIPanGestureRecognizer, view: inout UIView) {
        interactor.panGestureOccurred(recognizer: recognizer, view: &view)
    }
    
    func pinchGestureOccurred(recognizer: UIPinchGestureRecognizer, view: inout UIView) {
        interactor.pinchGestureOccurred(recognizer: recognizer, view: &view)
    }
    

    //MARK: func for building by pan a BuildingCard
    func showBuilding(_ card: BuildingCard, on position: SCNVector3) -> Bool {
        interactor.showBuilding(card, on: position)
    }
    
    func pan(_ buildingCard: BuildingCard, by position: SCNVector3) {
        interactor.pan(buildingCard, by: position)
    }
    
    func buildTower(with type: BuildingTypes, by coordinate: (Int, Int)) {
        interactor.buildTower(with: type, by: coordinate)
    }
}


