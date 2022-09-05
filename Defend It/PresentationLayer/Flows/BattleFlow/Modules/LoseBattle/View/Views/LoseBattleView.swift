//
//  LoseBattleView.swift
//  Defend It
//
//  Created by Роман Сенкевич on 26.07.22.
//

import UIKit

protocol LoseBattleViewDelegate: AnyObject {
    func goToHomePagePressed()
}

class LoseBattleView: UIView {
    
    let startButtonHeight: CGFloat = 50
    let startButtonWidth: CGFloat = 170
    
    let statusLabelHeight: CGFloat = 50
    let statusLabelWidth: CGFloat = 300
    
    var startButton: RectangleButton!
    var statusLabel = UILabel()
    
    weak var delegate: LoseBattleViewDelegate!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .gray
        setStartButton()
        setStatusLabel()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setStatusLabel() {
        
        self.addSubview(statusLabel)
        
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            statusLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            statusLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -100),
            statusLabel.heightAnchor.constraint(equalToConstant: statusLabelHeight),
            statusLabel.widthAnchor.constraint(equalToConstant: statusLabelWidth)
        ])
        
        statusLabel.backgroundColor = .systemBlue
        statusLabel.text = "You Are Lose"
        statusLabel.textAlignment = .center
    }
    
    func setStartButton() {
        
        let size = CGSize(width: startButtonWidth, height: startButtonHeight)
        let frame = CGRect(origin: .zero, size: size)
        startButton = RectangleButton(frame: frame)
        self.addSubview(startButton)
        
        startButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            startButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            startButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -50),
            startButton.heightAnchor.constraint(equalToConstant: startButtonHeight),
            startButton.widthAnchor.constraint(equalToConstant: startButtonWidth)
        ])
        startButton.configure(size: size, colour: .green)
        startButton.setTitle("Home", for: .normal)
        
        /// touch target
        startButton.addTarget(self, action: #selector(startButtonTouchUpInside), for: .touchUpInside)
        
        startButton.addTarget(self, action: #selector(startButtonTouchDown), for: .touchDown)

        startButton.addTarget(self, action: #selector(startButtonTouchDragExit), for: .touchDragExit)
        

    }
    
    @objc func startButtonTouchUpInside() {
        UIAnimations.rapidIncreaseAndDecreaseAnimation(view: startButton)
        delegate.goToHomePagePressed()
    }
    
    @objc func startButtonTouchDown() {
        UIAnimations.bagButtonSizeReductionAnimation(view: startButton)
    }
    
    @objc func startButtonTouchDragExit() {
        UIAnimations.rapidIncreaseAndDecreaseAnimation(view: startButton)
    }
    
}

