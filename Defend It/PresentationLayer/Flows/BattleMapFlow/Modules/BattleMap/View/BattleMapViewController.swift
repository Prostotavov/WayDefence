// 
//  BattleMapViewController.swift
//  Defend It
//
//  Created by Роман Сенкевич on 26.07.22.
//

import UIKit

class BattleMapViewController: UIViewController, ___VARIABLE_productName___ViewInput, ___VARIABLE_productName___ViewCoordinatorOutput {

    var output: ___VARIABLE_productName___ViewOutput!
    var assembler: ___VARIABLE_productName___AssemblyProtocol = ___VARIABLE_productName___Assembly()
    
    var onAccept: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assembler.assemblyModuleForViewInput(viewInput: self)
        output.viewDidLoad()
    }
    
    func setupInitialState() {
        
    }
}

