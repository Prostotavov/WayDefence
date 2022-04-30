//
//  Cameras.swift
//  Defend It
//
//  Created by MacBook Pro on 19.03.22.
//

import Foundation
import SceneKit

protocol Cameras {
    var scnVerticalNode: SCNNode! {get set}
    var scnHorisontalNode: SCNNode! {get set}
}

class CamerasImpl: Cameras {
    
    var scnVerticalNode: SCNNode!
    var scnHorisontalNode: SCNNode!
    
    init() {
        createVerticalCamera()
        createHorisontalCamera()
    }
    
    func createVerticalCamera() {
        scnVerticalNode = SCNNode()
        scnVerticalNode.camera = SCNCamera()
        scnVerticalNode.camera?.usesOrthographicProjection = true
        scnVerticalNode.camera?.projectionDirection = .vertical
        scnVerticalNode.camera?.orthographicScale = 2.2
        scnVerticalNode.eulerAngles = SCNVector3Make(-0.8, -0.5, 0)
        scnVerticalNode.position = SCNVector3(x: 0.8, y: 2.8, z: 3.2)
    }
    
    func createHorisontalCamera() {
        scnHorisontalNode = SCNNode()
        scnHorisontalNode.camera = SCNCamera()
        scnHorisontalNode.camera?.usesOrthographicProjection = true
        scnHorisontalNode.camera?.projectionDirection = .horizontal
        scnHorisontalNode.camera?.orthographicScale = 2.2
        scnHorisontalNode.eulerAngles = SCNVector3Make(-0.8, -0.5, 0)
        scnHorisontalNode.position = SCNVector3(x: 0.8, y: 2.8, z: 3.2)
    }

    
}
