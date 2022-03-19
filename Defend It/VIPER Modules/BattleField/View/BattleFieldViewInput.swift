// 
//  BattleFieldViewInput.swift
//  Defend It
//
//  Created by MacBook Pro on 16.03.22.
//

import Foundation

protocol BattleFieldViewInput: AnyObject {
    func createGround(size: Int)
    func createFence(size: Int)
}
