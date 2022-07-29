// 
//  BattleMapViewController.swift
//  Defend It
//
//  Created by Роман Сенкевич on 26.07.22.
//

import UIKit
import SpriteKit
import GameplayKit

class BattleMapViewController: UIViewController, BattleMapViewInput, BattleMapViewCoordinatorOutput, UIGestureRecognizerDelegate {
    
    // MARK: Properties

    var output: BattleMapViewOutput!
    var assembler: BattleMapAssemblyProtocol = BattleMapAssembly()
    
    var onAccept: (() -> Void)?
    
    var battleMapScene: BattleMapScene!
    
    // MARK: View Controller Lifecycle
    
    override func loadView() {
        view = SKView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure the view.
        let skView = self.view as! SKView
        skView.ignoresSiblingOrder = true
        skView.showsFPS = true
        skView.showsNodeCount = true
        
        // Configure the scene.
        battleMapScene = BattleMapScene(size: skView.bounds.size)
        battleMapScene.scaleMode = .resizeFill
        
        // Present the scene.
        skView.presentScene(battleMapScene)
        
        assembler.assemblyModuleForViewInput(viewInput: self)
        
        
        
        
        
        
        output.viewDidLoad()
    }
    
    // MARK: View Controller Configuration
    
    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    // MARK: Memory Management
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    
    
    
    func setupInitialState() {
        
    }
}
