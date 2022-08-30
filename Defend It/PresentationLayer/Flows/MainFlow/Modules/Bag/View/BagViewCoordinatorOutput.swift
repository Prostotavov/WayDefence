// 
//  BagViewCoordinatorOutput.swift
//  Defend It
//
//  Created by Роман Сенкевич on 30.08.22.
//

import Foundation

protocol BagViewCoordinatorOutput: Presentable {
    var onBack: (() -> Void)? { get set }
}
