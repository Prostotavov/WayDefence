// 
//  BattleFieldPresenter.swift
//  Defend It
//
//  Created by MacBook Pro on 16.03.22.
//

import Foundation

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
}
