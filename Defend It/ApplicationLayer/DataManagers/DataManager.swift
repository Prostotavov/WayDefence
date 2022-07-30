//
//  DataManager.swift
//  Defend It
//
//  Created by MacBook Pro on 16.03.22.
//

import UIKit

protocol DataManager {
    var countPassedMission: Int {get set}
}

class DataManagerImpl: DataManager {
    var countPassedMission: Int = 0
}
