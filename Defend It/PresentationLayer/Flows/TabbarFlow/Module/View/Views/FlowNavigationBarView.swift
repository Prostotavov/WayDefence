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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        let size = CGSize(width: self.frame.width / 3, height: self.frame.height / 27)
        setupCoinsLabel(size: size)
        setupGemsLabel(size: size)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func displayValue(of valueType: EconomicAccountValueTypes, to value: Int) {
        switch valueType {
        case .coins: coinStatusBar.configureValue(value: value)
        case .gems: gemsStatusBar.configureValue(value: value)
        case .points: return
        }
    }
}

extension FlowTabbarTopBarView {
    
    private func setupCoinsLabel(size: CGSize) {
        
        coinStatusBar = GameStatusBar(frame: CGRect(origin: .zero, size: size))
        coinStatusBar.configure(imageName: "money", value: 0, isPlusButton: true)
        
        self.addSubview(coinStatusBar)
        coinStatusBar.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            coinStatusBar.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            coinStatusBar.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: -self.frame.width / 4),
            coinStatusBar.widthAnchor.constraint(equalToConstant: size.width),
            coinStatusBar.heightAnchor.constraint(equalToConstant: size.height)
        ])
    }
    
    private func setupGemsLabel(size: CGSize) {
        
        gemsStatusBar = GameStatusBar(frame: CGRect(origin: .zero, size: size))
        gemsStatusBar.configure(imageName: "diamond", value: 0, isPlusButton: true)
        
        self.addSubview(gemsStatusBar)
        gemsStatusBar.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            gemsStatusBar.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            gemsStatusBar.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: self.frame.width / 4),
            gemsStatusBar.widthAnchor.constraint(equalToConstant: size.width),
            gemsStatusBar.heightAnchor.constraint(equalToConstant: size.height)
        ])
    }
}
