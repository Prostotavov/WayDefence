// 
//  BattleFieldInteractorInput.swift
//  Defend It
//
//  Created by MacBook Pro on 16.03.22.
//

import Foundation

protocol BattleFieldInteractorInput: AnyObject {
    func createGround(size: Int) -> [[GroundCell]]
    func createFence(size: Int) -> [FenceCell]
}
