// 
//  AchieveViewCoordinatorOutput.swift
//  Defend It
//
//  Created by Роман Сенкевич on 9.09.22.
//

import Foundation

protocol AchieveViewCoordinatorOutput: Presentable {
    var onBack: (() -> Void)? { get set }
}
