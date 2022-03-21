//
//  DecorationsManager.swift
//  Defend It
//
//  Created by MacBook Pro on 21.03.22.
//

import SceneKit

protocol DecorationsManager {
    func createFence() -> [FenceCell]
}

struct DecorationsManagerImpl: DecorationsManager {
    var battleFieldSize: Int!
    var fence = FenceImpl()
    
    init(_ battleFieldSize: Int) {
        self.battleFieldSize = battleFieldSize
    }
    
    func createFence() -> [FenceCell] {
        fence.createFence(size: battleFieldSize)
    }
}
