// 
//  AchieveAssemblyProtocol.swift
//  Defend It
//
//  Created by Роман Сенкевич on 9.09.22.
//

import Foundation

protocol AchieveAssemblyProtocol: AnyObject {
    
    func assemblyModuleForViewInput<UIViewController>(viewInput: UIViewController)
}
