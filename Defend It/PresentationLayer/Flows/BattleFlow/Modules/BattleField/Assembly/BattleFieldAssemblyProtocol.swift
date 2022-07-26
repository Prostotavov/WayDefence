// 
//  BattleFieldAssemblyProtocol.swift
//  Defend It
//
//  Created by MacBook Pro on 16.03.22.
//

import Foundation

protocol BattleFieldAssemblyProtocol: AnyObject {
    
    func assemblyModuleForViewInput<UIViewController>(viewInput: UIViewController)
    func setDelegate(delegate: BattleFieldAssemblyDelagate)
}
