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
    
    var coinsLabel: UILabel!
    var livesLabel: UILabel!
    var pointsLabel: UILabel!
    
    var pauseButton: UIButton!
    
    weak var delegate: TopBarViewDelegate!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .brown
        setupCoinsLabel()
        setupLivesLabel()
        setupPointsLabel()
        setupPauseButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupCoinsLabel() {
        coinsLabel = UILabel()
        coinsLabel.text = "coins"
        coinsLabel.backgroundColor = .blue
        coinsLabel.textColor = .brown
        
        self.addSubview(coinsLabel)
        coinsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            coinsLabel.topAnchor.constraint(equalTo: self.topAnchor),
            coinsLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            coinsLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                                constant: self.frame.width / 4),
            coinsLabel.trailingAnchor.constraint(equalTo: self.leadingAnchor,
                                                 constant: self.frame.width / 2)
        ])
        coinsLabel.textAlignment = .center
    }
    
    func setupLivesLabel() {
        livesLabel = UILabel()
        livesLabel.text = "lives"
        livesLabel.backgroundColor = .red
        livesLabel.textColor = .white
        
        self.addSubview(livesLabel)
        livesLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            livesLabel.topAnchor.constraint(equalTo: self.topAnchor),
            livesLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            livesLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                                 constant: self.frame.width / 2),
            livesLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor,
                                                 constant: -self.frame.width/4)
        ])
        livesLabel.textAlignment = .center
    }
    
    func setupPointsLabel() {
        pointsLabel = UILabel()
        pointsLabel.text = "points"
        pointsLabel.backgroundColor = .darkGray
        pointsLabel.textColor = .white
        
        self.addSubview(pointsLabel)
        pointsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pointsLabel.topAnchor.constraint(equalTo: self.topAnchor),
            pointsLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            pointsLabel.leadingAnchor.constraint(equalTo: self.trailingAnchor,
                                                 constant: -self.frame.width / 4),
            pointsLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
        pointsLabel.textAlignment = .center
    }
    
    func setupPauseButton() {
        pauseButton = UIButton()
        pauseButton.backgroundColor = .gray
        pauseButton.setTitle("Pause", for: .normal)
        pauseButton.setTitleColor(.white, for: .normal)
        pauseButton.titleLabel?.textColor = .green
        pauseButton.titleLabel?.textAlignment = .left
        self.addSubview(pauseButton)
        pauseButton.addTarget(self, action: #selector(pauseButtonPressed), for: .touchUpInside)
        
        pauseButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pauseButton.topAnchor.constraint(equalTo: self.topAnchor),
            pauseButton.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            pauseButton.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            pauseButton.trailingAnchor.constraint(equalTo: self.leadingAnchor,
                                                  constant: self.frame.width / 4)
        ])
        
    }
    
    @objc func pauseButtonPressed() {
        delegate.pauseButtonPressed()
    }
}

extension TopBarView {
    
    func displayValue(of value: EconomicBattleValueTypes, to number: Int) {
        switch value {
        case .coins: coinsLabel.text = "🤑 \(number)"
        case .lives: livesLabel.text = "❤️ \(number)"
        case .points: pointsLabel.text = "⭐️ \(number)"
        }
    }
}
