//
//  FlowNavigationBarView.swift
//  Defend It
//
//  Created by Роман Сенкевич on 6.08.22.
//

import UIKit

class FlowTabbarTopBarView: UIView {
    
    private var coinsLabel: UILabel!
    private var gemsLabel: UILabel!
    private var pointsLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .brown
        setupCoinsLabel()
        setupGemsLabel()
        setupPointsLabel()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func displayValue(of valueType: EconomicAccountValueTypes, to value: Int) {
        switch valueType {
        case .coins: coinsLabel.text = "🤑 \(value)"
        case .gems: gemsLabel.text = "💎 \(value)"
        case .points: pointsLabel.text = "⭐️ \(value)"
        }
    }
}

extension FlowTabbarTopBarView {
    
    private func setupCoinsLabel() {
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
    
    private func setupGemsLabel() {
        gemsLabel = UILabel()
        gemsLabel.text = "gems"
        gemsLabel.backgroundColor = .red
        gemsLabel.textColor = .white
        
        self.addSubview(gemsLabel)
        gemsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            gemsLabel.topAnchor.constraint(equalTo: self.topAnchor),
            gemsLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            gemsLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                                 constant: self.frame.width / 2),
            gemsLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor,
                                                 constant: -self.frame.width/4)
        ])
        gemsLabel.textAlignment = .center
    }
    
    private func setupPointsLabel() {
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
}
