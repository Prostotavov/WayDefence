//
//  HomePageViewCoordinatorOutput.swift
//  Defend It
//
//  Created by Роман Сенкевич on 25.07.22.
//

import Foundation

protocol HomePageViewCoordinatorOutput: Presentable {
    
    var onStartBattle: (() -> Void)? { get set }
    var onBagButton: (() -> Void)? { get set }
    var onQuestsButton: (() -> Void)? { get set }
    var onAchieveButton: (() -> Void)? { get set }
}
