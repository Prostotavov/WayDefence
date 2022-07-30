//
//  PauseBattleView.swift
//  Defend It
//
//  Created by Роман Сенкевич on 26.07.22.
//

import UIKit

protocol PauseBattleViewDelegate: AnyObject {
    func playBattonPressed()
    func goToHomePagePressed()
}

class PauseBattleView: UIView {
    
    let startButtonHeight: CGFloat = 50
    let startButtonWidth: CGFloat = 300
    
    let statusLabelHeight: CGFloat = 50
    let statusLabelWidth: CGFloat = 300
    
    var playButton = UIButton()
    var goToHomePageButton = UIButton()
    var statusLabel = UILabel()
    
    weak var delegate: PauseBattleViewDelegate!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .gray
        setStartButton()
        setGoToHomePageButton()
        setStatusLabel()
        playButton.addTarget(self, action: #selector(playButtonPressed), for: .touchUpInside)
        goToHomePageButton.addTarget(self, action: #selector(goToHomePagePressed), for: .touchUpInside)
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
        statusLabel.text = "Pause Battle"
        statusLabel.textAlignment = .center
    }
    
    func setStartButton() {
        
        self.addSubview(playButton)
        
        playButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            playButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            playButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            playButton.heightAnchor.constraint(equalToConstant: startButtonHeight),
            playButton.widthAnchor.constraint(equalToConstant: startButtonWidth)
        ])
        
        playButton.backgroundColor = .systemBlue
        playButton.setTitle("Tap To Play", for: .normal)
    }
    
    func setGoToHomePageButton() {
        
        self.addSubview(goToHomePageButton)
        
        goToHomePageButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            goToHomePageButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            goToHomePageButton.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 100),
            goToHomePageButton.heightAnchor.constraint(equalToConstant: startButtonHeight),
            goToHomePageButton.widthAnchor.constraint(equalToConstant: startButtonWidth)
        ])
        
        goToHomePageButton.backgroundColor = .systemBlue
        goToHomePageButton.setTitle("Tap to go Home Page", for: .normal)
    }
    
    @objc func playButtonPressed() {
        delegate.playBattonPressed()
    }
    
    @objc func goToHomePagePressed() {
        delegate.goToHomePagePressed()
    }
    
}
