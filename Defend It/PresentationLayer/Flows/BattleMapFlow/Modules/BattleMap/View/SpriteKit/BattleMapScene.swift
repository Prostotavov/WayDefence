//
//  BattleMapScene.swift
//  Defend It
//
//  Created by Роман Сенкевич on 29.07.22.
//

import SpriteKit
import GameplayKit

class BattleMapScene: SKScene, UIGestureRecognizerDelegate {
    
    // MARK: Properties
    
    // The game layer node holds our battleMap game objects.
    // In a typical game this might be called backgroundLayer to hold all the background nodes,
    // or enemyLayer to hold all of the enemy sprite nodes, these types of SKNodes are used to keep the
    // game objects organized and easier to work with.
    let gameLayer: SKNode!
    
    // The whole point of this project is to demonstrate our SKCameraNode subclass!
    let battleMapCamera: BattleMapCamera!
    
    var initialScale: CGFloat = 1.0
    
    // MARK: Initializers
    
    // Init
    override init(size: CGSize) {
        
        // Initialize the game layer node that will hold our game pieces and
        // move the gameLayer node to the center of the scene
        gameLayer = SKNode()
        gameLayer.position = CGPoint(x: 0, y: 0)
        
        // Initailize the battleMap camera
        battleMapCamera = BattleMapCamera()
//        battleMapCamera.showScale()
//        battleMapCamera.showPosition()
//        battleMapCamera.showViewport()
        
        // Call the super class initializer
        super.init(size: size)
        
        backgroundColor = SKColor.lightGray
        
        // Set the scene's camera
        // If you do not add the camera as a child of the scene panning and zooming will still work,
        // but none of the children of the camera will be rendered. So, no HUD or game controls.
        addChild(battleMapCamera)
        camera = battleMapCamera

        
        // Add the game layer node to the scene
        addChild(gameLayer)
    }
    
    // When not using an .sks file to build our scenes, we must have this method
    required init?(coder aDecoder: NSCoder) {
        fatalError("Coder not used in this app")
    }
    
    // MARK: Scene Lifecycle
    
    override func didMove(to view: SKView) {
        // Call any custom code to setup the scene
        
        let panGesture = UIPanGestureRecognizer()
        panGesture.addTarget(self, action: #selector(handlePanGesture(recognizer:)))
        panGesture.delegate = self
        self.view!.addGestureRecognizer(panGesture)
        
        let pinchGesture = UIPinchGestureRecognizer()
        pinchGesture.addTarget(self, action: #selector(handlePinchGesture(recognizer:)))
        self.view!.addGestureRecognizer(pinchGesture)
        
        addGamePieces()
    }
    
    // Called before each frame is rendered
    override func update(_ currentTime: TimeInterval) {
        // Update the camera each frame
        battleMapCamera.update()
    }
    
    // MARK: Touch-based event handling
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        battleMapCamera.stop()
    }
    
    @objc func handlePanGesture(recognizer: UIPanGestureRecognizer) {
        // While user interaction is happening simply apply thier changes directly to the camera
        // Translation must be multiplied by scale to keep a consistent motion at all levels
        
        var resistance: CGFloat = 1
        // These conditions create resistance to camera movement. When you move the camera outside, the movement decreases
        if battleMapCamera.position.x > battleMapCamera.range.x.max {
            let difference: CGFloat = battleMapCamera.position.x - battleMapCamera.range.x.max
            resistance = 1.0 + difference / 70.0
        }
        
        if battleMapCamera.position.x < battleMapCamera.range.x.min {
            let difference: CGFloat = battleMapCamera.range.x.min - battleMapCamera.position.x
            resistance = 1.0 + difference / 70.0
        }
        
        if battleMapCamera.position.y > battleMapCamera.range.y.max {
            let difference: CGFloat = battleMapCamera.position.y - battleMapCamera.range.y.max
            resistance = 1.0 + difference / 70.0
        }
        
        if battleMapCamera.position.y < battleMapCamera.range.y.min {
            let difference: CGFloat = battleMapCamera.range.y.min - battleMapCamera.position.y
            resistance = 1.0 + difference / 70.0
        }
        
        let translation = recognizer.translation(in: self.view)
        battleMapCamera.position = CGPoint(x: battleMapCamera.position.x - (translation.x * battleMapCamera.xScale / resistance),
                                      y: battleMapCamera.position.y + (translation.y * battleMapCamera.yScale / resistance))
        
        // reset the translation so that next cycle we get the delta from our new position
        recognizer.setTranslation(CGPoint.zero, in: self.view)
        
        // Once user interaction ends set camera's velocity so it can continue to move and slow to a stop
        if (recognizer.state == .ended) {
            let panVelocity = (recognizer.velocity(in: view))
            
            // this condition returns the camera to the maximum allowable value if the velocity is zero
            if panVelocity.x == 0 && panVelocity.y == 0 {
                if battleMapCamera.position.x > battleMapCamera.range.x.max || battleMapCamera.position.x < battleMapCamera.range.x.min ||
                    battleMapCamera.position.y > battleMapCamera.range.y.max || battleMapCamera.position.y < battleMapCamera.range.y.min {
                    battleMapCamera.setCameraPositionVelocity(x: 0.1, y: 0.1)
                    return
                }
            }
            battleMapCamera.setCameraPositionVelocity(x: panVelocity.x / 100, y: panVelocity.y / 100)
        }
    }
    
    @objc func handlePinchGesture(recognizer: UIPinchGestureRecognizer) {
        // Update the camera's scale velocity based on user interaction.
        // Recognizer velocity is reduced to provide a more pleasant user experience.
        // Increase or decrease the divisor to create a faster or slower camera.
        if (recognizer.state == .changed) {
            
            var resistance: CGFloat = 1
            let deltaScale = recognizer.scale - 1.0
            let scaleMultiplier = 1.0 - deltaScale
            
            if battleMapCamera.xScale > battleMapCamera.range.z.max {
                let difference: CGFloat = battleMapCamera.xScale - battleMapCamera.range.z.max
                resistance = 1.0 + difference / 100
            }
            if battleMapCamera.xScale < battleMapCamera.range.z.min {
                let difference: CGFloat = battleMapCamera.range.z.min - battleMapCamera.xScale
                resistance = 1/(1.0 + difference / 100)
            }
            battleMapCamera.setScale(battleMapCamera.xScale * scaleMultiplier / resistance)
            recognizer.scale = 1.0
        }

        if (recognizer.state == .ended) {
            // this condition bellow is triggered when we move the camera away or closer beyond the maximum or minimum change and the speed is zero
            if battleMapCamera.xScale > battleMapCamera.range.z.max && recognizer.velocity == 0 ||
                battleMapCamera.xScale < battleMapCamera.range.z.min && recognizer.velocity == 0 {
                battleMapCamera.setCameraScaleVelocity(z: -0.1)
                return
            }
            battleMapCamera.setCameraScaleVelocity(z: recognizer.velocity / 100)
//            print("Final Scale = \(battleMapCamera.xScale)")
        }
        
    }
    
    // MARK: Gesture Recognizer Delegate
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                           shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        // Since this demo only configures two gesture recognizers and we want them to work simultaneously we only need to return true.
        // If additional gesture recognizers are added there could be a need to add aditional logic here to setup which specific
        // recognizers should be working together.
        return true;
    }
    
    
    // MARK: Private Functions
    
    // This function just sets up a bunch of shape nodes so we can demonstrate the camera panning and zooming.
    private func addGamePieces() {
        // Keeping column and row numbers even will keep the game centered about the origin because we're working with integers
        let columns = 18
        let rows = 18
        for column in 0...columns - 1 {
            for row in 0...rows - 1 {
                let spriteGamePiece = SKSpriteNode(imageNamed: "tile")
                spriteGamePiece.position = CGPoint(x: (column * 120) - (columns * 60) + 60, y: (row * 120) - (rows * 60) + 60)
                gameLayer.addChild(spriteGamePiece)
            }
        }
        let centerGamePiece = SKShapeNode(circleOfRadius: 5.0)
        centerGamePiece.strokeColor = .red
        centerGamePiece.fillColor = .red
        centerGamePiece.position = CGPoint(x: 0, y: 0)
        gameLayer.addChild(centerGamePiece)
    
    }
}

