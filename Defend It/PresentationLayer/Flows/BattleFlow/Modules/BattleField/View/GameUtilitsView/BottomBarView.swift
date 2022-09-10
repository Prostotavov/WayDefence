//
//  BottomBarView.swift
//  Defend It
//
//  Created by Роман Сенкевич on 9.05.22.
//

import UIKit

protocol BottomBarViewDelegate: NSObject {
    func stopButtonPressed()
    func playButtonPressed()
}

class BottomBarView: UIView {
    
    var stopButton: UIButton!
    var playButton: UIButton!
    weak var delegate: BottomBarViewDelegate!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        setupStopButton()
        setupPlayButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupStopButton() {
        stopButton = UIButton()
        stopButton.backgroundColor = .blue
        stopButton.setTitle("stop", for: .normal)
        stopButton.titleLabel?.textColor = .brown
        stopButton.titleLabel?.textAlignment = .center
        self.addSubview(stopButton)
        stopButton.addTarget(self, action: #selector(stopButtonPressed), for: .touchUpInside)
        
        stopButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stopButton.topAnchor.constraint(equalTo: self.topAnchor),
            stopButton.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            stopButton.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stopButton.trailingAnchor.constraint(equalTo: self.leadingAnchor,
                                                 constant: self.frame.width / 3)
        ])
        
    }
    
    func setupPlayButton() {
        playButton = UIButton()
        playButton.backgroundColor = .blue
        playButton.setTitle("play", for: .normal)
        playButton.titleLabel?.textColor = .brown
        playButton.titleLabel?.textAlignment = .center
        self.addSubview(playButton)
        playButton.addTarget(self, action: #selector(playButtonPressed), for: .touchUpInside)
        
        playButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            playButton.topAnchor.constraint(equalTo: self.topAnchor),
            playButton.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            playButton.leadingAnchor.constraint(equalTo: self.trailingAnchor,
                                                 constant: -self.frame.width / 3),
            playButton.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
        
    }

    
    @objc func stopButtonPressed() {
        delegate.stopButtonPressed()
    }
    @objc func playButtonPressed() {
        delegate.playButtonPressed()
    }
    
}
