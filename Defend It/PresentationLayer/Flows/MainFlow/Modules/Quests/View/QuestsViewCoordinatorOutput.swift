// 
//  QuestsViewCoordinatorOutput.swift
//  Defend It
//
//  Created by Роман Сенкевич on 5.09.22.
//

import Foundation

protocol QuestsViewCoordinatorOutput: Presentable {
    var onBack: (() -> Void)? { get set }
}
