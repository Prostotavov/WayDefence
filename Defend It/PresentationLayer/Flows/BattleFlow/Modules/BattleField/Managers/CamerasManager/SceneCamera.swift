//
//  SceneCamera.swift
//  Defend It
//
//  Created by Роман Сенкевич on 2.08.22.
//

import SceneKit

class SceneCamera: SCNNode {
    var childNode: SCNNode!
    var mainCamera: SCNCamera!
    var zoomScale: Float {
        get {
            Float(mainCamera.orthographicScale)
        }
    }
    
    private var velocity: (x: Float, z: Float, scale: Float) = (0, 0, 0)
    private var friction: Float = 0.95
    private var attraction: (x: Float, z: Float, scale: Float) = (0, 0, 0)
    private var attractiveForce: Float = 0.2
    var range: (x: (min: Float, max: Float),
                z: (min: Float, max: Float),
                scale: (min: Float, max: Float)) = ((20, 35), (20, 35),(1, 3))
    
    var xAngle: Float!
    var yAngle: Float!
    var zAngle: Float!
    
    var initialPosition: SCNVector3! {
        willSet {
            position = newValue
        }
    }
    var initialEulerAngles: SCNVector3! {
        willSet {
            childNode.eulerAngles = newValue
            xAngle = newValue.x
            yAngle = newValue.y
            zAngle = newValue.z
        }
    }
    var initialScale: Float! {
        willSet {
            setZoomScale(newValue)
        }
    }

    
    func applyDefaultInitialState() {
        initialPosition = SCNVector3()
        initialEulerAngles = SCNVector3()
        initialScale = 1
    }
    
    func applyCurrentInitialPosition() {
        let moveAction = SCNAction.move(to: initialPosition, duration: 0.1)
        self.runAction(moveAction)
    }
    
    override init() {
        super.init()
        setupChildNode()
        setupMainCamera()
        applyDefaultInitialState()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Coder not used in this app")
    }
    
    private func setupChildNode() {
        childNode = SCNNode()
        self.addChildNode(childNode)
    }
    
    private func setupMainCamera() {
        mainCamera = SCNCamera()
        mainCamera.usesOrthographicProjection = true
        childNode.camera = mainCamera
    }
    
    func setCameraFriction(force: Float) {
        friction = force
    }
    func setCameraAttractiveForce(force: Float) {
        attractiveForce = force
    }
    
    func stop() {
        if zoomScale < range.scale.max && zoomScale > range.scale.min {
            velocity.scale = 0
            attraction.scale = 0
        }
        velocity.x = 0; velocity.z = 0
        attraction.x = 0; attraction.z = 0
        self.removeAllActions()
    }
    
    func update() {
        if (velocity.x != 0 || velocity.z != 0 || attraction.x != 0 || attraction.z != 0) {
            updatePosition()
        }
        
        if (velocity.scale != 0 || attraction.scale != 0) {
            updateScale()
        }
    }
    
}

// funcs for pan camera
extension SceneCamera {
    func setCameraPositionVelocity(x: Float!, z: Float!) {
        if (x != nil) {
            velocity.x = x * zoomScale
        }
        
        if (z != nil) {
            velocity.z = z * zoomScale
        }
    }
    
    private func updatePosition() {
        // When either x or y position is less than the minimum values allowed or greater than the maximum values allowed they need to be pulled back into compliance using attraction and the attractive force.
        
        // Update attraction x
        if (Float(position.x) < range.x.min) {
            // Calculate how far below the minimum x value the camera is by subracting min from position, the result will be negative.
            attraction.x = Float(position.x) - range.x.min
            
            // Multiply by the attractive force to...
            attraction.x *= attractiveForce
        } else if (Float(position.x) > range.x.max) {
            // Calculate how far above the maximum x value the camera is by subtracting max from position, the result will be positive.
            attraction.x = Float(position.x) - range.x.max
            
            // Multiply by the attractive force to...
            attraction.x *= attractiveForce
        } else {
            // If the position is inside the range then there is no need to attract the camera back into the range.
            attraction.x = 0.0
        }
        
        // Update attraction y
        if (Float(position.z) < range.z.min) {
            attraction.z = Float(position.z) - range.z.min
            attraction.z *= attractiveForce
        } else if (Float(position.z) > range.z.max) {
            attraction.z = position.z - range.z.max
            attraction.z *= attractiveForce
        } else {
            attraction.z = 0.0
        }
        
        // Apply friction to x velocity so the camera can slow to a stop
        velocity.x *= friction
        
        // Since friction is typically a value like 0.95 it will mathematically never reach zero, so we need to set a minimum velocity where we can assume the camera has basically stopped moving.
        if (abs(velocity.x) < 0.01) {
            velocity.x = 0
        }
        
        // Apply friction to the y velocity so the camera can slow to a stop
        velocity.z *= friction
        
        // Stop the camera when velocity has approached close enough to zero
        if (abs(velocity.z) < 0.01) {
            velocity.z = 0
        }

        // velocity for right left
        position.z += velocity.x + attraction.x
        position.x -= velocity.x + attraction.x
        
        // velocity for up down
        position.z -= velocity.z  + attraction.z
        position.x -=  velocity.z + attraction.z
    }
}

// funcs for zoom
extension SceneCamera {
    func setCameraScaleVelocity(scale: Float) {
        velocity.scale = scale * zoomScale
    }
    
    private func applyScaleForces() {
        
        // Test if xScale is outside its range and set an attraction to the bound it has exceded
        // so that the attraction can be applied when updating the camera's position
        if (zoomScale < range.scale.min) {
            attraction.scale = range.scale.min - zoomScale
            attraction.scale *= attractiveForce
        } else if (zoomScale > range.scale.max) {
            attraction.scale = range.scale.max - zoomScale
            attraction.scale *= attractiveForce
        } else {
            attraction.scale = 0
        }
        
        
        // Apply friction to velocity so the camera slows to a stop when user interaction ends.
        velocity.scale *= friction
    }
    
    private func updateScale() {
        applyScaleForces()
        setZoomScale(zoomScale - velocity.scale + attraction.scale)
    }
    
    func setZoomScale(_ scale: Float) {
        mainCamera.orthographicScale = Double(scale)
    }
}

// handleGesture
extension SceneCamera {
    
    func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        stop()
        
    }
    func handleDoubleTap() {
        applyCurrentInitialPosition()
    }
    
    func handlePanGesture(recognizer: UIPanGestureRecognizer, view: inout UIView) {
        let xMyltiplayer: Float = cos(-xAngle)
        let yMyltiplayer: Float = sin(xAngle)
        let zMyltiplayer: Float = sin(yAngle)
        
        
        
        var resistance: Float = 1
        // These conditions create resistance to camera movement. When you move the camera outside, the movement decreases
        if position.x > range.x.max {
            let difference: Float = position.x - range.x.max
            resistance = 1.0 + difference / 70.0
        }
        
        if position.x < range.x.min {
            let difference: Float = range.x.min - position.x
            resistance = 1.0 + difference / 70.0
        }
        
        if position.y > range.z.max {
            let difference: Float = position.y - range.z.max
            resistance = 1.0 + difference / 70.0
        }
        
        if position.y < range.z.min {
            let difference: Float = range.z.min - position.y
            resistance = 1.0 + difference / 70.0
        }
        
        let translation = recognizer.translation(in: view)
        
        
        var yPan = Float(translation.y) * zoomScale / resistance / 290
        + Float(translation.x) * zoomScale / resistance / 290 * yMyltiplayer
        yPan = yPan * 290 / 165
        
        position.x = position.x
        - Float(translation.x) * zoomScale / resistance / 290 / xMyltiplayer
        - yPan * zMyltiplayer
        
        position.z = position.z - yPan * zMyltiplayer
        
        // reset the translation so that next cycle we get the delta from our new position
        recognizer.setTranslation(CGPoint.zero, in: view)
        
        // Once user interaction ends set camera's velocity so it can continue to move and slow to a stop
        if (recognizer.state == .ended) {
            let panVelocity = (recognizer.velocity(in: view))
            
            // this condition returns the camera to the maximum allowable value if the velocity is zero
            if panVelocity.x == 0 && panVelocity.y == 0 {
                if position.x > range.x.max ||
                    position.x < range.x.min ||
                    position.y > range.z.max ||
                    position.y < range.z.min {
                    setCameraPositionVelocity(x: 0.1, z: 0.1)
                    return
                }
            }
            let xPanVelocity = Float(panVelocity.x) / 30000
            var yPanVelocity = Float(panVelocity.y) / 30000
            yPanVelocity = yPanVelocity * 290 / 165
            
            setCameraPositionVelocity(x: xPanVelocity / xMyltiplayer,z: yPanVelocity)
        }
    }
    
    func handlePinchGesture(recognizer: UIPinchGestureRecognizer, view: inout UIView) {
        if (recognizer.state == .changed) {
            
            let deltaScale: Float = Float(recognizer.scale) - 1.0
            let scaleMultiplier: Float = 1.0 - deltaScale
            
            setZoomScale(zoomScale * scaleMultiplier)
            recognizer.scale = 1.0
        }
        
        if (recognizer.state == .ended) {
            // this condition bellow is triggered when we move the camera away or closer beyond the maximum or minimum change and the speed is zero
            if zoomScale > range.z.max && recognizer.velocity == 0 ||
                zoomScale < range.z.min && recognizer.velocity == 0 {
                setCameraScaleVelocity(scale: -0.1)
                return
            }
            setCameraScaleVelocity(scale: Float(recognizer.velocity) / 100)
        }
    }
}

