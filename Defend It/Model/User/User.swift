//
//  User.swift
//  Defend It
//
//  Created by Роман Сенкевич on 5.08.22.
//

import Foundation



protocol User {
    
}

class UserImp: User {
    
    private var name: String?
    private var age: String?
    private var sex: UserSex?
    
    private var login: String?
    private var password: String?
}
