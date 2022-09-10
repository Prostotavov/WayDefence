// 
//  LoseBattleViewController.swift
//  Defend It
//
//  Created by Роман Сенкевич on 26.07.22.
//

import UIKit

class LoseBattleViewController: UIViewController, LoseBattleViewInput, LoseBattleViewCoordinatorOutput {

    var output: LoseBattleViewOutput!
    var assembler: LoseBattleAssemblyProtocol = LoseBattleAssembly()
    
    var onAccept: (() -> Void)?
    
    var loseBattleView = LoseBattleView()
    
    override func loadView() {
        loseBattleView.delegate = self
        view = loseBattleView
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

extension LoseBattleViewController: LoseBattleViewDelegate {
    func goToHomePagePressed() {
        output.onAcceptTap()
    }
    
}
