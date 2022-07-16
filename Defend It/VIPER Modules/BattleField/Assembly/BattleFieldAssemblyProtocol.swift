// 
//  BattleFieldAssemblyProtocol.swift
//  Defend It
//
//  Created by MacBook Pro on 16.03.22.
//

import Foundation

protocol BattleFieldAssemblyProtocol: AnyObject {
    
    func assembly(with viewController: BattleFieldViewController)
    func setDelegate(delegate: BattleFieldAssemblyDelagate)
}
