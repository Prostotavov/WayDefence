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
    var camerasManager: CamerasManager!
    
    var battle: Battle!
    
    func loadView() {
        setupCamera()
        battle.output = self
        battle.startBattle()
    }
    
    func playGame() {
        battle.playBattle()
    }
    
    func stopGame() {
        battle.stopBattle()
    }
    
    func viewDidAppear() {
        battle.displayBattleValues()
    }
    
    func displayValues(of valueType: BattleValueTypes, to number: Int) {
        output.displayValue(of: valueType, to: number)
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
    }
}


// funcs for setup camera
extension BattleFieldInteractor {
    func setupCamera() {
        output.addNodeToScene(camerasManager.parentCameraNode)
        output.setupPointOfView(from: camerasManager.chieldCameraNode)
    }
    
    func fixCurrentPosition() {
        camerasManager.fixCurrentPosition()
    }
    
    func dragCamera(by position: SCNVector3) {
        camerasManager.dragCamera(by: position)
        output.setupPointOfView(from: camerasManager.chieldCameraNode)
    }
    
    func deviceOrientationChanged(to orientation: UIDeviceOrientation) {
        switch orientation {
        case .portrait:
            camerasManager.switchToVerticalCamera()
            output.setupPointOfView(from: camerasManager.chieldCameraNode)
            output.setViewVerticalOrientation()
        default :
            camerasManager.switchToHorisontalCamera()
            output.setupPointOfView(from: camerasManager.chieldCameraNode)
            output.setViewHorisontalOrientation()
        }
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
}
