//
//  WinBattleView.swift
//  Defend It
//
//  Created by Роман Сенкевич on 26.07.22.
//

import UIKit

protocol WinBattleViewDelegate: AnyObject {
    func goToHomePagePressed()
}

class WinBattleView: UIView {
    
    let startButtonHeight: CGFloat = 50
    let startButtonWidth: CGFloat = 300
    
    let statusLabelHeight: CGFloat = 50
    let statusLabelWidth: CGFloat = 300
    
    var startButton = UIButton()
    var statusLabel = UILabel()
    var rewardLabel = UILabel()
    
    let rewardCollectionView = RewardsCollectionView()
    
    weak var delegate: WinBattleViewDelegate!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .gray
        setStartButton()
        setStatusLabel()
        setRewardLabel()
        setCollectionView()
        startButton.addTarget(self, action: #selector(goToHomePagePressed), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setCollectionView() {
        self.addSubview(rewardCollectionView)
        
        rewardCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            rewardCollectionView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            rewardCollectionView.topAnchor.constraint(equalTo: rewardLabel.bottomAnchor, constant: 30)
        ])
    }

    
    func setStatusLabel() {
        
        self.addSubview(statusLabel)
        
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            statusLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            statusLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -150),
            statusLabel.heightAnchor.constraint(equalToConstant: statusLabelHeight),
            statusLabel.widthAnchor.constraint(equalToConstant: statusLabelWidth)
        ])
        
        statusLabel.backgroundColor = .systemBlue
        statusLabel.text = "You Are Win"
        statusLabel.textAlignment = .center
    }
    
    func setRewardLabel() {
        
        self.addSubview(rewardLabel)
        
        rewardLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            rewardLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            rewardLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -70),
            rewardLabel.heightAnchor.constraint(equalToConstant: statusLabelHeight),
            rewardLabel.widthAnchor.constraint(equalToConstant: statusLabelWidth)
        ])
        
        rewardLabel.backgroundColor = .systemBlue
        rewardLabel.text = "Your reward"
        rewardLabel.textAlignment = .center
    }
    
    func setStartButton() {
        
        self.addSubview(startButton)
        
        startButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            startButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            startButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -50),
            startButton.heightAnchor.constraint(equalToConstant: startButtonHeight),
            startButton.widthAnchor.constraint(equalToConstant: startButtonWidth)
        ])
        
        startButton.backgroundColor = .systemBlue
        startButton.setTitle("Tap to go Home Page", for: .normal)
    }
    
    @objc func goToHomePagePressed() {
        delegate.goToHomePagePressed()
    }
    
}
