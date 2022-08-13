//
//  SceneCameraConverter.swift
//  Defend It
//
//  Created by Роман Сенкевич on 2.08.22.
//

import SceneKit

class SceneCameraConverter {
    
    static func toDegreesFrom(radians: SCNVector3) -> SCNVector3 {
        return SCNVector3(x: radians.x * 180 / 3.14,
                          y: radians.y * 180 / 3.14,
                          z: radians.z * 180 / 3.14)
    }
    
    static func toRadiansFrom(degrees: SCNVector3) -> SCNVector3 {
        return SCNVector3(x: degrees.x * 3.14 / 180,
                          y: degrees.y * 3.14 / 180,
                          z: degrees.z * 3.14 / 180)
    }
}
