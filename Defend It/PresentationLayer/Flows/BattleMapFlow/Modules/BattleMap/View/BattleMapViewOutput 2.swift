// 
//  BattleMapViewOutput.swift
//  Defend It
//
//  Created by Роман Сенкевич on 26.07.22.
//

import Foundation

protocol BattleMapViewOutput: AnyObject {
    
    func viewDidLoad()
    func onBattleIconPressed()
    
    func battleIconPressed(byId id: Int)
}
