// 
//  WinBattleAssemblyProtocol.swift
//  Defend It
//
//  Created by Роман Сенкевич on 26.07.22.
//

import Foundation

protocol WinBattleAssemblyProtocol: AnyObject {
    
    func assemblyModuleForViewInput<UIViewController>(viewInput: UIViewController)
}
