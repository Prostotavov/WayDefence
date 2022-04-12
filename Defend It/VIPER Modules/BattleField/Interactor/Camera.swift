//
//  Camera.swift
//  Defend It
//
//  Created by MacBook Pro on 19.03.22.
//

import Foundation
import SceneKit

protocol Camera {
    var scnNode: SCNNode! {get set}
}

class CameraImpl: Camera {
    
    var scnNode: SCNNode!
    
    init() {
        createCamera()
    }
    
    func createCamera() {
        scnNode = SCNNode()
        scnNode.camera = SCNCamera()
        
        scnNode.position = SCNVector3(x: 1.5, y: 4, z: 1.5)
        let xAngle = Float(-180 * Float(180 / 3.14))
        scnNode.eulerAngles = SCNVector3Make(xAngle, 0, 0)
    }
    
}
