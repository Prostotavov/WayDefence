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
        scnNode.camera?.usesOrthographicProjection = true
        scnNode.camera?.orthographicScale = 2.6
        scnNode.eulerAngles = SCNVector3Make(-0.8, -0.5, 0)
        scnNode.position = SCNVector3(x: 0.8, y: 2.8, z: 3.2)
    }
    
}
