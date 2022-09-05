// 
//  QuestsViewController.swift
//  Defend It
//
//  Created by Роман Сенкевич on 5.09.22.
//

import UIKit

class QuestsViewController: UIViewController, QuestsViewInput, QuestsViewCoordinatorOutput {

    var output: QuestsViewOutput!
    var assembler: QuestsAssemblyProtocol = QuestsAssembly()
    
    let questsView = QuestsView()
    
    var onBack: (() -> Void)?
    
    override func loadView() {
        questsView.delegate = self
        view = questsView
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

extension QuestsViewController: QuestsViewDelegate {
    func backButtonPressed() {
        output.onBackPressed()
    }
}

