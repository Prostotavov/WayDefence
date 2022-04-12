//
//  MeadowManager.swift
//  Defend It
//
//  Created by MacBook Pro on 26.03.22.
//

import Foundation

protocol MeadowManager {
    func getGroundSquares() -> [[GroundSquareImpl]]
}

class MeadowManagerImpl: MeadowManager {
    var ground: Ground!
    var battleFieldSize: Int!
    
    init(_ battleFieldSize: Int) {
        self.battleFieldSize = battleFieldSize
        createGround(size: battleFieldSize)
    }
    
    private func createGround(size: Int) {
        ground = GroundImpl(size: size)
    }
    
    func getGroundSquares() ->  [[GroundSquareImpl]] {
        ground.squares
    }
}
