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

extension BattleFieldPresenter {
    
    func pressed(_ node: SCNNode) {
        
        let parentNode = getParentNodeFor(node)
        
        switch node.name {
        case _ where node.name! == RecognitionNodes.sellSelectIcon.rawValue:
            interactor.sellBuilding(on: parentNode.position)
            interactor.hideTowerSelectionPanel()
            
        case _ where node.name! == RecognitionNodes.repairSelectIcon.rawValue:
            interactor.repairBuilding(on: parentNode.position)
            
        case _ where node.name!.contains(RecognitionNodes.floor.rawValue):
            interactor.hideTowerSelectionPanel()
            
        case _ where node.name!.contains(RecognitionNodes.groundSquare.rawValue):
            interactor.showTowerSelectionPanel(on: parentNode.position)
            
        case _ where node.name!.contains(RecognitionNodes.selectIcon.rawValue):
            let buildingType = Converter.toBuildingType(from: node.name!)!
            interactor.build(buildingType, on: parentNode.position)
            
        case _ where node.name!.contains(RecognitionNodes.builtTower.rawValue):
            interactor.showTowerSelectionPanel(on: parentNode.position)
        default:
            print("default case in BattleFieldPresenter")
            break
        }
    }
    
    func getParentNodeFor(_ childNode: SCNNode) -> SCNNode {
        var parentNode: SCNNode!
        if childNode.parent?.parent != nil {
            parentNode = getParentNodeFor(childNode.parent!)
        } else {
            parentNode = childNode
        }
        return parentNode
    }
}

enum RecognitionNodes: String  {
    case floor = "floor"
    case groundSquare = "groundSquare"
    case selectIcon = "SelectIcon"
    case builtTower = "builtTower"
    case sellSelectIcon = "sellSelectIcon"
    case repairSelectIcon = "repairSelectIcon"

}
