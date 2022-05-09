//
//  TopBarView.swift
//  Defend It
//
//  Created by Роман Сенкевич on 9.05.22.
//

import UIKit

class TopBarView: UIView {
    
    var coinsLabel: UILabel!
    var livesLabel: UILabel!
    var pointsLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .brown
        setupCoinsLabel()
        setupLivesLabel()
        setupPointsLabel()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupCoinsLabel() {
        coinsLabel = UILabel()
        coinsLabel.text = "coins"
        coinsLabel.backgroundColor = .blue
        coinsLabel.textColor = .white
        
        self.addSubview(coinsLabel)
        coinsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            coinsLabel.topAnchor.constraint(equalTo: self.topAnchor),
            coinsLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            coinsLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            coinsLabel.trailingAnchor.constraint(equalTo: self.leadingAnchor,
                                                 constant: self.frame.width / 3)
        ])
        coinsLabel.textAlignment = .center
    }
    
    func setupLivesLabel() {
        livesLabel = UILabel()
        livesLabel.text = "lives"
        livesLabel.backgroundColor = .blue
        livesLabel.textColor = .white
        
        self.addSubview(livesLabel)
        livesLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            livesLabel.topAnchor.constraint(equalTo: self.topAnchor),
            livesLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            livesLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                                 constant: self.frame.width / 3),
            livesLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor,
                                                 constant: -self.frame.width/3)
        ])
        livesLabel.textAlignment = .center
    }
    
    func setupPointsLabel() {
        pointsLabel = UILabel()
        pointsLabel.text = "points"
        pointsLabel.backgroundColor = .blue
        pointsLabel.textColor = .white
        
        self.addSubview(pointsLabel)
        pointsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pointsLabel.topAnchor.constraint(equalTo: self.topAnchor),
            pointsLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            pointsLabel.leadingAnchor.constraint(equalTo: self.trailingAnchor,
                                                 constant: -self.frame.width / 3),
            pointsLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
        pointsLabel.textAlignment = .center
    }
}

extension TopBarView {
    
    func set(_ value: BattleValues, to number: Int) {
        switch value {
        case .coins: coinsLabel.text = "🤑 \(number)"
            print(number)
        case .lives: livesLabel.text = "❤️ \(number)"
        case .points: pointsLabel.text = "⭐️ \(number)"
        }
    }
}
