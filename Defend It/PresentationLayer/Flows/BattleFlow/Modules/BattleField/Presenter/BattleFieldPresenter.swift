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
    func onAcceptTap() {
        coordinator.onFinishBattle?()
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
    func deviceOrientationChanged(to orientation: UIDeviceOrientation) {
        interactor.deviceOrientationChanged(to: orientation)
    }
    func setupPointOfView(from cameraNode: SCNNode) {
        view.setupPointOfView(from: cameraNode)
    }
    func setViewHorisontalOrientation() {
        view.setViewHorisontalOrientation()
    }
    func setViewVerticalOrientation() {
        view.setViewVerticalOrientation()
    }
    
    /// func for map and pan camera
    func panGestureChanged(by translation: CGPoint) {
        let position = Converter.toPosition(from: translation)
        interactor.dragCamera(by: position)
    }
    func panGestureEnded() {
        interactor.fixCurrentPosition()
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
    func displayValue(of valueType: BattleValueTypes, to number: Int) {
        view.displayValue(of: valueType, to: number)
    }

    /// user can stop and play the game
    func playButtonPressed() {
        interactor.playGame()
    }
    func stopButtonPressed() {
        interactor.stopGame()
    }
    
    /// func for handle pressed node by user
    func pressedNode(_ node: SCNNode) {
        interactor.pressedNode(node)
    }

}


