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
    
    func createGround(size: Int) -> [[GroundCell]] {
        return interactor.createGround(size: size)
    }
    
    func createFence(size: Int) -> [FenceCell] {
        return interactor.createFence(size: size)
    }
    
    func getEnemy(size: Int) -> Enemy {
        return interactor.getEnemy(size: size)
    }
    
    func setupCamera() -> SCNNode {
        interactor.setupCamera()
    }
    
    func getTowerSelectionPanel(position: SCNVector3) -> SCNNode {
        interactor.getTowerSelectionPanel(position: position)
    }
    
    func create(_ building: Buildings, On position: SCNVector3) ->  SCNNode {
        interactor.create(building, On: position)
    }
    
    func runToCastle() {
        interactor.runToCastle()
    }
}
