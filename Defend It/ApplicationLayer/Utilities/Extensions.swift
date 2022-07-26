//
//  Extensions.swift
//  Defend It
//
//  Created by Роман Сенкевич on 16.05.22.
//

import SceneKit

extension SCNVector3 {
    
    static func -(left: SCNVector3, right: SCNVector3) -> SCNVector3 {
        return SCNVector3(left.x - right.x + right.z * sin(0.5),left.y,
                          left.z - right.z - right.x * sin(0.5))
    }
}
