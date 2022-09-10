//
//  FlowNavigationBarView.swift
//  Defend It
//
//  Created by Роман Сенкевич on 6.08.22.
//

import UIKit

class FlowTabbarTopBarView: UIView {
    
    private var coinStatusBar: GameStatusBar!
    private var gemsStatusBar: GameStatusBar!
    private var pointsStatusBar: GameStatusBar!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        let size = CGSize(width: self.frame.width / 3.7, height: self.frame.height / 27)
        setupCoinsLabel(size: size)
        setupGemsLabel(size: size)
        setupPointsLabel(size: size)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func displayValue(of valueType: EconomicAccountValueTypes, to value: Int) {
        switch valueType {
        case .coins: coinStatusBar.configureValue(value: value)
        case .gems: gemsStatusBar.configureValue(value: value)
        case .points: pointsStatusBar.configureValue(value: value)
        }
    }
}

extension FlowTabbarTopBarView {
    
    private func setupCoinsLabel(size: CGSize) {
        
        coinStatusBar = GameStatusBar(frame: CGRect(origin: .zero, size: size))
        coinStatusBar.configure(imageName: "bag", value: 0, isPlusButton: true)
        
        self.addSubview(coinStatusBar)
        coinStatusBar.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            coinStatusBar.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            coinStatusBar.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: -self.frame.width / 3),
            coinStatusBar.widthAnchor.constraint(equalToConstant: size.width),
            coinStatusBar.heightAnchor.constraint(equalToConstant: size.height)
        ])
    }
    
    private func setupGemsLabel(size: CGSize) {
        
        gemsStatusBar = GameStatusBar(frame: CGRect(origin: .zero, size: size))
        gemsStatusBar.configure(imageName: "shield", value: 0, isPlusButton: true)
        
        self.addSubview(gemsStatusBar)
        gemsStatusBar.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            gemsStatusBar.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            gemsStatusBar.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            gemsStatusBar.widthAnchor.constraint(equalToConstant: size.width),
            gemsStatusBar.heightAnchor.constraint(equalToConstant: size.height)
        ])
    }
    
    private func setupPointsLabel(size: CGSize) {
        
        pointsStatusBar = GameStatusBar(frame: CGRect(origin: .zero, size: size))
        pointsStatusBar.configure(imageName: "arch", value: 0, isPlusButton: true)
        
        self.addSubview(pointsStatusBar)
        pointsStatusBar.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pointsStatusBar.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            pointsStatusBar.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: self.frame.width / 3),
            pointsStatusBar.widthAnchor.constraint(equalToConstant: size.width),
            pointsStatusBar.heightAnchor.constraint(equalToConstant: size.height)
        ])
    }
}
