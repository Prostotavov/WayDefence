//
//  User.swift
//  Defend It
//
//  Created by Роман Сенкевич on 5.08.22.
//

import Foundation

protocol User {
    var gameAccount: GameAccount? {get}
}

class UserImp: User {
    
    private var name: String?
    private var age: String?
    private var sex: UserSex?
    
    private var login: String?
    private var password: String?
    
    var gameAccount: GameAccount?
    
    static let shared = UserImp()
    
    init() {
        self.gameAccount = GameAccountImp()
    }
}
