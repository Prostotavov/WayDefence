//
//  HomePageView.swift
//  Defend It
//
//  Created by MacBook Pro on 16.03.22.
//

import UIKit

protocol HomePageViewDelegate: AnyObject {
    func startButtonPressed()
    func bagButtonPressed()
}

class HomePageView: UIView {
    
    let startButtonHeight: CGFloat = 50
    let startButtonWidth: CGFloat = 130
    
    var startButton: RectangleButton!
    var bagButton: BagButton!
    
    weak var delegate: HomePageViewDelegate!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .gray
        setStartButton()
        setupBagButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setStartButton() {
        let size = CGSize(width: startButtonWidth, height: startButtonHeight)
        let frame = CGRect(origin: .zero, size: size)
        startButton = RectangleButton(frame: frame)
        self.addSubview(startButton)
        
        startButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            startButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            startButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            startButton.heightAnchor.constraint(equalToConstant: startButtonHeight),
            startButton.widthAnchor.constraint(equalToConstant: startButtonWidth)
        ])
        
        startButton.configure(size: size, colour: .green)
        startButton.setTitle("Start", for: .normal)
        
        /// touch target
        startButton.addTarget(self, action: #selector(startButtonTouchUpInside), for: .touchUpInside)
        
        startButton.addTarget(self, action: #selector(startButtonTouchDown), for: .touchDown)

        startButton.addTarget(self, action: #selector(startButtonTouchDragExit), for: .touchDragExit)
        

    }
    
    @objc func startButtonTouchUpInside() {
        UIAnimations.rapidIncreaseAndDecreaseAnimation(view: startButton)
        delegate.startButtonPressed()
    }
    
    @objc func startButtonTouchDown() {
        UIAnimations.bagButtonSizeReductionAnimation(view: startButton)
    }
    
    @objc func startButtonTouchDragExit() {
        UIAnimations.rapidIncreaseAndDecreaseAnimation(view: startButton)
    }
    
}

// bag view
extension HomePageView {
    func setupBagButton() {
        let size = CGSize(width: 70, height: 70)
        let frame = CGRect(origin: .zero, size: size)
        bagButton = BagButton(frame: frame)
        self.addSubview(bagButton)
        bagButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            bagButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -100),
            bagButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -50),
            bagButton.widthAnchor.constraint(equalToConstant: 70),
            bagButton.heightAnchor.constraint(equalToConstant: 70)
        ])
        
        
        bagButton.addTarget(self, action: #selector(bagButtonPressed), for: .touchUpInside)
        
        bagButton.addTarget(self, action: #selector(bagButtonSizeReductionAnimation), for: .touchDown)
        
        bagButton.addTarget(self, action: #selector(rapidIncreaseAndDecreaseAnimation), for: .touchDragOutside)
    }
    
    @objc func rapidIncreaseAndDecreaseAnimation() {
        UIAnimations.rapidIncreaseAndDecreaseAnimation(view: bagButton)
    }
    
    
    @objc func bagButtonSizeReductionAnimation() {
        UIAnimations.bagButtonSizeReductionAnimation(view: bagButton)
    }

    @objc func bagButtonPressed() {
        rapidIncreaseAndDecreaseAnimation()
        delegate.bagButtonPressed()
    }
}

