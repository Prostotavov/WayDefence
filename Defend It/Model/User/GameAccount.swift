//
//  GameAccount.swift
//  Defend It
//
//  Created by Роман Сенкевич on 5.08.22.
//

import Foundation

protocol GameAccount: AnyObject {
    
}

class GameAccountImp: GameAccount {
    private var avatar: String?
    private var coins: Int?
    private var points: Int?
    private var gems: Int?
    private var level: Int?
    private var boosters: [Int]? // add later
}
