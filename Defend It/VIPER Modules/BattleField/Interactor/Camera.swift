//
//  Camera.swift
//  Defend It
//
//  Created by MacBook Pro on 19.03.22.
//

import Foundation
import SceneKit

protocol Camera {
    mutating func setupCamera() -> SCNNode
}

struct CameraImpl: Camera {
    
    mutating func setupCamera() -> SCNNode {
        let scnCameraNode = SCNNode()
        scnCameraNode.camera = SCNCamera()
        
        scnCameraNode.position = SCNVector3(x: 1.5, y: 4, z: 1.5)
        let xAngle = Float(-180 * Float(180 / 3.14))
        scnCameraNode.eulerAngles = SCNVector3Make(xAngle, 0, 0)
        print("")
        return scnCameraNode
    }
}
