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
    
    var pauseBattleView: PauseBattleView!
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.modalPresentationStyle = .overFullScreen
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pauseBattleView = PauseBattleView(frame: view.bounds)
        pauseBattleView.delegate = self
        view.addSubview(pauseBattleView)
        pauseBattleView.alpha = 0
        
        assembler.assemblyModuleForViewInput(viewInput: self)
        output.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        show()
    }
    
    func setupInitialState() {
        
    }
    
    func playBattonPressed() {
        output.onPlayTap()
    }
    
    func goToHomePagePressed() {
        output.goToHomePagePressed()
    }
    
    func appear(sender: UIViewController) {
        sender.present(self, animated: false) {
            self.show()
        }
    }
    
    private func show() {
        UIView.animate(withDuration: 0.25) {
            self.pauseBattleView.alpha = 1
        }
    }
    
    private func hide() {
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseOut) {
            self.pauseBattleView.alpha = 0
        } completion: { _ in
            self.dismiss(animated: false)
            self.removeFromParent()
        }
        
    }
    
    private func fastHide() {
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseOut) {
            self.pauseBattleView.alpha = 0
        } completion: { _ in
            self.dismiss(animated: false)
            self.removeFromParent()
        }
        
    }
    
    func restart(){
        hide()
    }
    func quit(){
        output.goToHomePagePressed()
        fastHide()
    }
    func play(){
        hide()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}

