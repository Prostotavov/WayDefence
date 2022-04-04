//
//  BuildingIconPlaces.swift
//  Defend It
//
//  Created by MacBook Pro on 4.04.22.
//

import Foundation

enum BuildingIconPlaces {
    case upLeftPlace
    case upMiddlePlace
    case upRightPlace
    case deleteTowerButton
    case downLeftPlace
    case downMiddlePlace
    case downRightPlace
    case repairTowerButton
}

//                board
//        ——————————————————————
//       |          |           |
//       |    0     1     2     |   0 - upLeftPlace, 1 - upMiddlePlace, 2 - upRightPlace
//       |          |           |
//        ————————tower——————————
//       |          |           |
//       3    4     5     6     7   4 - downLeftPlace, 5 - downMiddlePlace, 6 - downRightPlace
//       |          |           |
//        ——————————————————————    3 - deleteTowerButton, 7 - repairTowerButton
