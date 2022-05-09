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
    var interactor: BattleFieldInteractorInput!
    var router: BattleFieldRouterInput!
    
    func loadView() {
        interactor.loadView()
    }
    
    func viewDidAppear() {
        interactor.viewDidAppear()
    }
    
    func add(_ node: SCNNode) {
        view.add(node)
    }
    
    func remove(_ node: SCNNode) {
        view.remove(node)
    }
    
    func removeNode(with name: String) {
        view.removeNode(with: name)
    }
    
    func pressed(_ node: SCNNode) {
        interactor.handlePressed(node)
    }
    
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
    
    func newFrameDidRender() {
        interactor.newFrameDidRender()
    }
    
    func didBegin(_ enemyNode: SCNNode, contactWith radiusNode: SCNNode) {
        interactor.didBegin(enemyNode, contactWith: radiusNode)
    }
    
    func didEnd(_ enemyNode: SCNNode, contactWith radiusNode: SCNNode) {
        interactor.didEnd(enemyNode, contactWith: radiusNode)
    }
    
    func set(_ value: BattleValues, to number: Int) {
        view.set(value, to: number)
    }

}
