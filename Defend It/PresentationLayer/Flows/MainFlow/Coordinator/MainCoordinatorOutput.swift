//
//  MainCoordinatorOutput.swift
//  Defend It
//
//  Created by Роман Сенкевич on 26.07.22.
//

import Foundation

protocol MainCoordinatorOutput: AnyObject {
    
    var finishFlow: (() -> Void)? { get set }
}
