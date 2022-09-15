// 
//  AchieveViewController.swift
//  Defend It
//
//  Created by Роман Сенкевич on 9.09.22.
//

import UIKit

class AchieveViewController: UIViewController, AchieveViewInput, AchieveViewCoordinatorOutput {

    var output: AchieveViewOutput!
    var assembler: AchieveAssemblyProtocol = AchieveAssembly()
    
    let achieveView = AchieveView()
    
    var onBack: (() -> Void)?

    
    override func loadView() {
        achieveView.delegate = self
        view = achieveView
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
    
    var centerYAnchor: NSLayoutConstraint!
    
    func showAlertView(rewards: BattleReward) {
        let size = CGSize(width: view.frame.width / 3, height: view.frame.height / 10)
        let alertView = GameAlertView(frame: CGRect(origin: .zero, size: size))
        view.addSubview(alertView)
        alertView.translatesAutoresizingMaskIntoConstraints = false
        
        centerYAnchor = alertView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        
        NSLayoutConstraint.activate([
            alertView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            centerYAnchor,
            alertView.heightAnchor.constraint(equalToConstant: size.height),
            alertView.widthAnchor.constraint(equalToConstant: size.width)
        ])
        
        alertView.configure(rewards: rewards)
        view.layoutIfNeeded()
        UIView.animateKeyframes(withDuration: 1.3, delay: 0, options: .calculationModeLinear) {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1) { [weak self] in
                alertView.alpha = 0
                self?.centerYAnchor.constant = -50
                self?.view.layoutIfNeeded()
            }
        } completion: { _ in
            alertView.removeFromSuperview()
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}

extension AchieveViewController: AchieveViewDelegate {
    func backButtonPressed() {
        output.onBackPressed()
    }
    
    func getButtonPressed(rewards: BattleReward) {
        showAlertView(rewards: rewards)
    }
}
