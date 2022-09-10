//
//  TopBarView.swift
//  Defend It
//
//  Created by Роман Сенкевич on 9.05.22.
//

import UIKit

protocol TopBarViewDelegate: AnyObject {
    func pauseButtonPressed()
}

class TopBarView: UIView {
    
    private var coinStatusBar: GameStatusBar!
    private var livesStatusBar: GameStatusBar!
    
    var pauseButton: UIButton!
    
    weak var delegate: TopBarViewDelegate!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        let size = CGSize(width: self.frame.width / 3.7, height: self.frame.height / 27)
        setupCoinsLabel(size: size)
        setupLivesLabel(size: size)
        setupPauseButton(size: size)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupCoinsLabel(size: CGSize) {
        coinStatusBar = GameStatusBar(frame: CGRect(origin: .zero, size: size))
        coinStatusBar.configure(imageName: "bag", value: 0, isPlusButton: true)
        
        self.addSubview(coinStatusBar)
        coinStatusBar.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            coinStatusBar.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            coinStatusBar.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: self.frame.width / 6),
            coinStatusBar.widthAnchor.constraint(equalToConstant: size.width),
            coinStatusBar.heightAnchor.constraint(equalToConstant: size.height)
        ])
    }
    
    func setupLivesLabel(size: CGSize) {
        livesStatusBar = GameStatusBar(frame: CGRect(origin: .zero, size: size))
        livesStatusBar.configure(imageName: "shield", value: 0, isPlusButton: true)
        
        self.addSubview(livesStatusBar)
        livesStatusBar.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            livesStatusBar.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            livesStatusBar.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: -self.frame.width / 6),
            livesStatusBar.widthAnchor.constraint(equalToConstant: size.width),
            livesStatusBar.heightAnchor.constraint(equalToConstant: size.height)
        ])
    }
    
    func setupPauseButton(size: CGSize) {
        pauseButton = PauseButton(frame: CGRect(origin: .zero, size: size))
        self.addSubview(pauseButton)
        
        pauseButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pauseButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            pauseButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: self.frame.width / 25),
            pauseButton.heightAnchor.constraint(equalToConstant: size.height * 2),
            pauseButton.widthAnchor.constraint(equalToConstant: size.height * 2)
        ])
        
        /// touch target
        pauseButton.addTarget(self, action: #selector(pauseButtonTouchUpInside), for: .touchUpInside)
        
        pauseButton.addTarget(self, action: #selector(pauseButtonTouchDown), for: .touchDown)
        
        pauseButton.addTarget(self, action: #selector(pauseButtonTouchDragExit), for: .touchDragExit)
        
    }
    
    @objc func pauseButtonTouchUpInside() {
        delegate.pauseButtonPressed()
        UIAnimations.rapidIncreaseAndDecreaseAnimation(view: pauseButton)
    }
    
    @objc func pauseButtonTouchDown() {
        UIAnimations.bagButtonSizeReductionAnimation(view: pauseButton)
    }
    
    @objc func pauseButtonTouchDragExit() {
        UIAnimations.rapidIncreaseAndDecreaseAnimation(view: pauseButton)
    }
}

extension TopBarView {
    
    func displayValue(of value: EconomicBattleValueTypes, to number: Int) {
        switch value {
        case .coins: coinStatusBar.configureValue(value: number)
        case .lives: livesStatusBar.configureValue(value: number)
        case .points: return
        }
    }
}
