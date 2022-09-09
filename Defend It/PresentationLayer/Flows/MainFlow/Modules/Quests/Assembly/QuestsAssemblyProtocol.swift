// 
//  QuestsAssemblyProtocol.swift
//  Defend It
//
//  Created by Роман Сенкевич on 5.09.22.
//

import Foundation

protocol QuestsAssemblyProtocol: AnyObject {
    
    func assemblyModuleForViewInput<UIViewController>(viewInput: UIViewController)
}
