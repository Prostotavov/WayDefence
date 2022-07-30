// 
//  PauseBattleViewController.swift
//  Defend It
//
//  Created by Роман Сенкевич on 26.07.22.
//

import UIKit

class PauseBattleViewController: UIViewController, PauseBattleViewInput, PauseBattleViewCoordinatorOutput, PauseBattleViewDelegate {

    var output: PauseBattleViewOutput!
    var assembler: PauseBattleAssemblyProtocol = PauseBattleAssembly()
    
    var onPlay: (() -> Void)?
    var onQuit: (() -> Void)?
    
    var pauseBattleView = PauseBattleView(frame: CGRect(x: 100, y: 100, width: 200, height: 300))
    
    override func loadView() {
        pauseBattleView.delegate = self
        view = pauseBattleView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assembler.assemblyModuleForViewInput(viewInput: self)
        output.viewDidLoad()
    }
    
    func setupInitialState() {
        
    }
    
    func playBattonPressed() {
        output.onPlayTap()
    }
    
    func goToHomePagePressed() {
        output.goToHomePagePressed()
    }
}

