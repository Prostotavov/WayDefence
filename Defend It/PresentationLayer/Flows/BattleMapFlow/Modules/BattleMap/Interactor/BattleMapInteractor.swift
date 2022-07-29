// 
//  BattleMapInteractor.swift
//  Defend It
//
//  Created by Роман Сенкевич on 26.07.22.
//

import Foundation

class BattleMapInteractor: BattleMapInteractorInput {
    
    weak var output: BattleMapInteractorOutput!
    var dataManager: DataManager!
    
    func battleIconPressed(byId id: Int) {
        print("interactor id: \(id)")
    }
}
