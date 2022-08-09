//
//  FlowTabbarAssemblyProtocol.swift
//  Defend It
//
//  Created by Роман Сенкевич on 6.08.22.
//

import Foundation

protocol FlowTabbarAssemblyProtocol: AnyObject {
    
    func assemblyModuleForViewInput<UIViewController>(viewInput: UIViewController)
}
