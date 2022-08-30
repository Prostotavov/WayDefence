// 
//  BagViewController.swift
//  Defend It
//
//  Created by Роман Сенкевич on 30.08.22.
//

import UIKit

class BagViewController: UIViewController, BagViewInput, BagViewCoordinatorOutput {

    var output: BagViewOutput!
    var assembler: BagAssemblyProtocol = BagAssembly()
    
    let bagView = BagView()
    
    var onBack: (() -> Void)?
    
    override func loadView() {
        bagView.delegate = self
        view = bagView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assembler.assemblyModuleForViewInput(viewInput: self)
        view.backgroundColor = .clear
        output.viewDidLoad()
    }
    
    func setupInitialState() {
        
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.modalPresentationStyle = .overFullScreen
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension BagViewController: BagViewDelegate {
    func backButtonPressed() {
        output.onBackPressed()
    }
}
