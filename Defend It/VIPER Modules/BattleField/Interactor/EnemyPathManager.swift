//
//  EnemyPathManager.swift
//  Defend It
//
//  Created by MacBook Pro on 21.03.22.
//

import Foundation
import SceneKit

protocol EnemyPathManager {
    func calculatePath() -> [SCNVector3]
}

class EnemyPathManagerImpl: EnemyPathManager {
    
    var startCoordinate: (Int, Int)!
    var targetCoordinate: (Int, Int)!
    var currentCoordinate: (Int, Int)!
    
    func calculatePath() -> [SCNVector3] {
        var testPath: [SCNVector3] = []
        let step1 = SCNVector3(0, 0, 0)
        let step2 = SCNVector3(1, 0, 0)
        let step3 = SCNVector3(1, 0, 1)
        let step4 = SCNVector3(1, 0, 2)
        testPath.append(step1)
        testPath.append(step2)
        testPath.append(step3)
        testPath.append(step4)
        return testPath
    }
}
