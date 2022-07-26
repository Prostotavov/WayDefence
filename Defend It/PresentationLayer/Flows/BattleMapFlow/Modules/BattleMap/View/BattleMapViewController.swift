// 
//  BattleMapViewController.swift
//  Defend It
//
//  Created by Роман Сенкевич on 26.07.22.
//

import UIKit

class BattleMapViewController: UIViewController, BattleMapViewInput, BattleMapViewCoordinatorOutput {

    var output: BattleMapViewOutput!
    var assembler: BattleMapAssemblyProtocol = BattleMapAssembly()
    
    var onAccept: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assembler.assemblyModuleForViewInput(viewInput: self)
        output.viewDidLoad()
    }
    
    func setupInitialState() {
        
    }
}

