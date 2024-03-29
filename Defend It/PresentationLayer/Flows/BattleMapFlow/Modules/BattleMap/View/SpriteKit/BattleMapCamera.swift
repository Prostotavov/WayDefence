//
//  BattleMapCamera.swift
//  Defend It
//
//  Created by Роман Сенкевич on 29.07.22.
//

import SpriteKit
import os.log

/// A battleMap camera implementation
class BattleMapCamera: SKCameraNode {
    
    // MARK: Properties
    
    /**
     Velocity is the value that the camera should move each frame in the x, y and z direction.
     
     x and y are position values and will adjust the pixel location of the camera in the scene.
     
     z is a scale value and will adjust the scale of the camera's viewport.
     */
    private var velocity: (x: CGFloat, y: CGFloat, z: CGFloat) = (0, 0, 0)
    
    /**
     friction is the value used to decrease the velocity of the camera after user interaction has ended to cause the camera to gradually slow to a stop.
     */
    private var friction: CGFloat = 0.95
    
    /**
     Attraction is a value derived from the distance the camera's position is outside of the camera's range.  It is used along with the attractive force to provide a 'soft' edge to the camera's range, allowing it to cross its min and max slightly and bounce back.
     */
    private var attraction: (x: CGFloat, y: CGFloat, z: CGFloat) = (0, 0, 0)
    
    /**
     AttractiveForce sets the 'softness' of the edge of the camera's range.
     
     A value of 1.0 will be a hard edge where the camera stops at it min and max ranges with no give or bounce.
     
     Smaller values will allow the camera to travel farther past its range and bounce back.
     
     A value of 0.0 will allow the camera to completely ignore its defined range.
     */
    private var attractiveForce: CGFloat = 0.2
    
    /// The cameras position and scale range
    var range: (x: (min: CGFloat, max: CGFloat),
                y: (min: CGFloat, max: CGFloat),
                z: (min: CGFloat, max: CGFloat)) = ((-1000, 1000), (-1000, 1000),(1, 3))
    
    /// A boolean value that indicates whether the camera displays a position indicator.
    private var showsPosition = false
    
    /// A boolean value that indicates whether the camera displays a scale indicator.
    private var showsScale = false
    
    /// A boolean value that indicates whether the camera displays a viewport indicator.
    private var showsViewport = false
    
    /// Position indicator that demonstrates adding game controls to the camera and aids in debugging.
    private let positionLabel = SKLabelNode(fontNamed: "AppleSDGothicNeo-SemiBold")
    
    /// Scale indicator that demonstrates adding game controls to the camera and aids in debugging.
    private let scaleLabel = SKLabelNode(fontNamed: "AppleSDGothicNeo-SemiBold")
    
    /// Viewport indicator that demonstrates adding game controls to the camera and aids in debugging.
    private let viewportLabel = SKLabelNode(fontNamed: "AppleSDGothicNeo-SemiBold")
    
    
    // MARK: Initializers
    
    /// Creates a camera node
    override init() {
        super.init()
        
        
    }
    
    /// Sks files are not used in this demo.
    required init?(coder aDecoder: NSCoder) {
        fatalError("Coder not used in this app")
    }
    
    
    // MARK: Camera Property Setters
    
    /**
     Set the velocity of the camera position and scale
     - Parameters:
     - x : the x velocity of the camera.
     - y : the y velocity of the camera.
     - z : the z velocity of the camera.
     */
    func setCameraVelocity(x: CGFloat!, y: CGFloat!, z: CGFloat!) {
        setCameraPositionVelocity(x: x, y: y)
        if (z != nil) {
            setCameraScaleVelocity(z: z)
        }
    }
    
    /**
     Set the camera's position velocity
     
     We multiply the velocity by scale so that panning appears to happen at the same rate at every zoom level.
     */
    func setCameraPositionVelocity(x: CGFloat!, y: CGFloat!) {
        if (x != nil) {
            velocity.x = x * xScale
        }
        
        if (y != nil) {
            velocity.y = y * yScale
        }
    }
    
    /**
     Set the camsera's scale velocity
     
     We multiply the velocity by scale so that zooming appears to happen at the same rate at every zoom level.
     */
    func setCameraScaleVelocity(z: CGFloat) {
        velocity.z = z * xScale
    }
    
    /// Set the camera's friction force
    func setCameraFriction(force: CGFloat) {
        if (force <= 0 || force >= 1.0) {
            os_log("Friction should be a number between 0 and 1", type: .error)
        }
        friction = force
    }
    
    /// Set the camera's attractive force
    func setCameraAttractiveForce(force: CGFloat) {
        if (force <= 0 || force >= 1.0) {
            os_log("Attractive force should be a number between 0 and 1", type: .error)
        }
        attractiveForce = force
    }
    
    
    // MARK: Updating the Camera
    
    
    /// set all forces that act upon the camera to 0, stoping the camera's motion
    func stop() {
//        print("Stop Camera Motion")
        velocity = (0.0, 0.0, 0.0)
        attraction = (0.0, 0.0, 0.0)
    }
    
    /// Update tells the camera to update itself
    func update() {
        if (velocity.x != 0 || velocity.y != 0 || attraction.x != 0 || attraction.y != 0) {
            updatePosition()
        }
        
        if (velocity.z != 0 || attraction.z != 0) {
            updateScale()
        }
        
        updateHUD()
        
    }
    
    /// Apply's forces to the camera's velocity and then upadtes its position
    private func updatePosition() {
        // When either x or y position is less than the minimum values allowed or greater than the maximum values allowed they need to be pulled back into compliance using attraction and the attractive force.
        
        // Update attraction x
        if (position.x < range.x.min) {
            // Calculate how far below the minimum x value the camera is by subracting min from position, the result will be negative.
            attraction.x = position.x - range.x.min
            
            // Multiply by the attractive force to...
            attraction.x *= attractiveForce
        } else if (position.x > range.x.max) {
            // Calculate how far above the maximum x value the camera is by subtracting max from position, the result will be positive.
            attraction.x = position.x - range.x.max
            
            // Multiply by the attractive force to...
            attraction.x *= attractiveForce
        } else {
            // If the position is inside the range then there is no need to attract the camera back into the range.
            attraction.x = 0.0
        }
        
        // Update attraction y
        if (position.y < range.y.min) {
            attraction.y = position.y - range.y.min
            attraction.y *= attractiveForce
        } else if (position.y > range.y.max) {
            attraction.y = position.y - range.y.max
            attraction.y *= attractiveForce
        } else {
            attraction.y = 0.0
        }
        
        // Apply friction to x velocity so the camera can slow to a stop
        velocity.x *= friction
        
        // Since friction is typically a value like 0.95 it will mathematically never reach zero, so we need to set a minimum velocity where we can assume the camera has basically stopped moving.
        if (abs(velocity.x) < 0.01) {
            velocity.x = 0
        }
        
        // Apply friction to the y velocity so the camera can slow to a stop
        velocity.y *= friction
        
        // Stop the camera when velocity has approached close enough to zero
        if (abs(velocity.y) < 0.01) {
            velocity.y = 0
        }
        
        
        
        //        if position.x > range.x.max || position.x < range.x.min ||
        //            position.y > range.y.max || position.y < range.y.min {
        //            print("--- \(position)")
        //        }
        
        position.x -= velocity.x + attraction.x
        position.y += velocity.y - attraction.y
    }
    
    /// Deprecated: everything should be moved into updateScale()
    private func applyScaleForces() {
        // x and y should always be scaling equally in this camera,
        // but just incase something happens to throw them out of whack... set them equal
        yScale = xScale
        
        // Test if xScale is outside its range and set an attraction to the bound it has exceded
        // so that the attraction can be applied when updating the camera's position
        if (xScale < range.z.min) {
            attraction.z = range.z.min - xScale
            attraction.z *= attractiveForce
        } else if (xScale > range.z.max) {
            attraction.z = range.z.max - xScale
            attraction.z *= attractiveForce
        } else {
            attraction.z = 0
        }
        
        
        // Apply friction to velocity so the camera slows to a stop when user interaction ends.
        velocity.z *= friction
    }
    
    
    
    // TODO: Applies forces to the camera's scale velocity and then updates the scale
    private func updateScale() {
        
        
        applyScaleForces()
        
        
        
        
        // Update the camera's scale
        setScale(xScale - velocity.z + attraction.z)
        //        if xScale > range.z.max || xScale < range.z.min {
        //            print("--- \(xScale)")
        //        }
        
    }
    
    
    // MARK: Heads Up Display
    
    /// Display the position indicator
    func showPosition() {
        if (!showsPosition) {
            showsPosition = true
            positionLabel.fontSize = 8
            positionLabel.fontColor = .white
            addChild(positionLabel)
        }
    }
    
    /// Display the scale indicator
    func showScale() {
        if (!showsScale) {
            showsScale = true
            scaleLabel.fontSize = 8
            scaleLabel.fontColor = .white
            scaleLabel.position = CGPoint(x:0.0, y: -15.0)
            addChild(scaleLabel)
        }
    }
    
    /// Display viewport indicator
    func showViewport() {
        if (!showsViewport) {
            showsViewport = true
            viewportLabel.fontSize = 8
            viewportLabel.fontColor = .white
            viewportLabel.position = CGPoint(x:0.0, y: -30.0)
            addChild(viewportLabel)
        }
    }
    
    /**
     Update the camera's SKLabelNode children.
     
     - Author:
     Sean Allen
     
     - Important:
     This function is called by the update() method.
     
     - Version:
     0.1
     
     The updateHUD() funcition is called by the update() method so that when the scale and position debug labels are enabled they will accurately display the current camera orientation.
     
     This HUD serves to provide information about the camera state and
     serves as an example of how to implement a HUD by adding nodes as children of the camera.
     */
    private func updateHUD() {
        if (showsPosition) {
            
            let x = position.x.rounded(FloatingPointRoundingRule.toNearestOrEven)
            let y = position.y.rounded(FloatingPointRoundingRule.toNearestOrEven)
            positionLabel.text = "position: (\(x), \(y))"
            positionLabel.position = CGPoint(x:parent!.frame.size.width / 2 - 50, y: -parent!.frame.size.height/2 + 30)
        }
        
        if (showsScale) {
            let scale = round(100 * xScale) / 100.0
            scaleLabel.text = "Scale: \(scale)"
            scaleLabel.position = CGPoint(x:parent!.frame.size.width / 2 - 50, y: -parent!.frame.size.height/2 + 40)
        }
        
        if (showsViewport) {
            viewportLabel.text = "Viewport: (\(parent!.frame.size.width), \(parent!.frame.size.height))"
            viewportLabel.position = CGPoint(x:parent!.frame.size.width / 2 - 50, y: -parent!.frame.size.height/2 + 20)
        }
    }
}


