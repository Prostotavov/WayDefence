//
//  Cameras.swift
//  Defend It
//
//  Created by MacBook Pro on 19.03.22.
//

import Foundation
import SceneKit

protocol CamerasManager {
    var parentCameraNode: SCNNode! {get}
    var chieldCameraNode: SCNNode! {get}
    
    func switchToVerticalCamera()
    func switchToHorisontalCamera()

    func fixCurrentPosition()
    func dragCamera(by position: SCNVector3)
}

class CamerasManagerImpl: CamerasManager {
    
    ///To simplify the process of moving the camera, we will divide our movement into two parts:
    ///1. in the parentCameraNode, we will only change the position
    ///2. in the chieldCameraNode, we will change only the euler angles
    ///in the child node there will be a camera
    
    var parentCameraNode: SCNNode!
    var chieldCameraNode: SCNNode!
    
    var verticalCamera: SCNCamera!
    var horisontalCamera: SCNCamera!
    
    var parentCameraNodePosition: SCNVector3 = SCNVector3(x: 0.8, y: 2.8, z: 3.2)
    var chieldEulerAngles = SCNVector3Make(-0.8, -0.5, 0)
    var orthographicScale = 2.2
    
    init() {
        setupCameraNodes()
        createVerticalCamera()
        createHorisontalCamera()
        switchToVerticalCamera() /// by default, we start with a vertical camera
    }
    
    private func setupCameraNodes() {
        parentCameraNode = SCNNode()
        parentCameraNode.position = parentCameraNodePosition
        
        chieldCameraNode = SCNNode()
        chieldCameraNode.eulerAngles = chieldEulerAngles
        
        parentCameraNode.addChildNode(chieldCameraNode)
    }
    
    private func createVerticalCamera() {
        verticalCamera = SCNCamera()
        verticalCamera.usesOrthographicProjection = true
        verticalCamera.projectionDirection = .vertical
        verticalCamera.orthographicScale = orthographicScale
    }
    
    private func createHorisontalCamera() {
        horisontalCamera = SCNCamera()
        horisontalCamera.usesOrthographicProjection = true
        horisontalCamera.projectionDirection = .horizontal
        horisontalCamera.orthographicScale = orthographicScale
    }
    
    func switchToVerticalCamera() {
        chieldCameraNode.camera = verticalCamera
    }
    
    func switchToHorisontalCamera() {
        chieldCameraNode.camera = verticalCamera
    }
    
    func dragCamera(by position: SCNVector3) {
        parentCameraNode.position = parentCameraNodePosition - position
    }
    
    func fixCurrentPosition() {
        parentCameraNodePosition = parentCameraNode.position
    }
    
}
