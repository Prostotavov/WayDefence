//
//  MeadowManager.swift
//  Defend It
//
//  Created by MacBook Pro on 26.03.22.
//

import Foundation

protocol MeadowManager {
    func createGround() -> [[GroundCell]]
}

class MeadowManagerImpl: MeadowManager {
    var ground: GroundTest = GroundTestImpl()
    var battleFieldSize: Int!
    
    init(_ battleFieldSize: Int) {
        self.battleFieldSize = battleFieldSize
    }
    
    func createGround() -> [[GroundCell]] {
        ground.createGround(size: battleFieldSize)
    }
}
