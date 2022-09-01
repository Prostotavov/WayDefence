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
    
    var startButton = UIButton()
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
        
        self.addSubview(startButton)
        
        startButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            startButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            startButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            startButton.heightAnchor.constraint(equalToConstant: startButtonHeight),
            startButton.widthAnchor.constraint(equalToConstant: startButtonWidth)
        ])
        
        startButton.backgroundColor = .systemBlue
        startButton.setTitle("Start", for: .normal)
        
        startButton.addTarget(self, action: #selector(startButtonPressed), for: .touchUpInside)
    }
    
    @objc func startButtonPressed() {
        delegate.startButtonPressed()
    }
    
}

// bag view
extension HomePageView {
    func setupBagButton() {
        bagButton = BagButton()
        self.addSubview(bagButton)
        bagButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            bagButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -100),
            bagButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -50)
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

