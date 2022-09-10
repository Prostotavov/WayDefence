//
//  SpeedButton.swift
//  Defend It
//
//  Created by Роман Сенкевич on 10.09.22.
//

import UIKit

class SpeedButton: UIButton {
    
    private var speedLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        firstBorder(size: frame.size)
        setupLabel(size: frame.size)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func changeBattleSpeed(into newValue: Int) {
        speedLabel.text = "x\(newValue)"
    }
    
    private func firstBorder(size: CGSize) {
        let rectangle = UIView(frame: .zero)

        self.addSubview(rectangle)
        rectangle.translatesAutoresizingMaskIntoConstraints = false
        rectangle.isUserInteractionEnabled = false
        
        NSLayoutConstraint.activate([
            rectangle.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            rectangle.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            rectangle.heightAnchor.constraint(equalToConstant: size.height * 1.7),
            rectangle.widthAnchor.constraint(equalToConstant: size.height * 1.7)
        ])
        
        rectangle.layer.cornerRadius = 7
        rectangle.backgroundColor = .darkGray
    }
    
    private func setupLabel(size: CGSize) {
        
        speedLabel = UILabel()

        self.addSubview(speedLabel)
        speedLabel.translatesAutoresizingMaskIntoConstraints = false
        speedLabel.isUserInteractionEnabled = false
        
        NSLayoutConstraint.activate([
            speedLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            speedLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
        
        speedLabel.text = "x\(0)"
        speedLabel.textColor = .white
        speedLabel.textAlignment = .center
    }
}
