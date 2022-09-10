// 
//  WinBattleViewController.swift
//  Defend It
//
//  Created by Роман Сенкевич on 26.07.22.
//

import UIKit

class WinBattleViewController: UIViewController, WinBattleViewInput, WinBattleViewCoordinatorOutput {

    var output: WinBattleViewOutput!
    var assembler: WinBattleAssemblyProtocol = WinBattleAssembly()
    
    var onAccept: (() -> Void)?
    
    var winBattleView = WinBattleView()
    
    override func loadView() {
        winBattleView.delegate = self
        view = winBattleView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assembler.assemblyModuleForViewInput(viewInput: self)
        output.viewDidLoad()
    }
    
    func setupInitialState() {
        
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}

extension WinBattleViewController: WinBattleViewDelegate {
    func goToHomePagePressed() {
        output.onAcceptTap()
    }
    
}

