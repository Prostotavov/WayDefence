// 
//  BattleFieldInteractor.swift
//  Defend It
//
//  Created by MacBook Pro on 16.03.22.
//

import Foundation

class BattleFieldInteractor: BattleFieldInteractorInput {
    
    weak var output: BattleFieldInteractorOutput!
    var dataManager: DataManager!
    
    var ground: Ground = GroundImpl()
    var fence: Fence = FenceImpl()
    
    func createGround(size: Int) -> [[GroundCell]] {
        return ground.createGround(size: size)
    }
    
    func createFence(size: Int) -> [FenceCell] {
        return fence.createFence(size: size)
    }
    
}
