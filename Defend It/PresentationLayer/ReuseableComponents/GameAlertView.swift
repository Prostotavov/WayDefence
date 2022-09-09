//
//  GameAlertView.swift
//  Defend It
//
//  Created by Роман Сенкевич on 8.09.22.
//

import UIKit

class GameAlertView: UIView {
    
    private var title: String?
    private var rewards: [BattleReward] = []
    
    private var equipmentView: EquipmentView?
    private var titleLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        firstBorder(size: frame.size)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configure(rewards: BattleReward) {
        guard let itemReward = rewards.equipments.first else {return}
        setRewardView(imageName: itemReward.item.imageName, text: String(itemReward.quantity))
        setTitleLabel(title: itemReward.item.type.rawValue)
    }
    
    private func setTitleLabel(title: String) {
        
        let label = UILabel()
        self.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.leftAnchor.constraint(equalTo: self.centerXAnchor, constant: -self.frame.width/20),
            label.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
        
        label.text = title
        label.textColor = .white
        label.textAlignment = .center
    }
    
    private func setRewardView(imageName: EquipmentImageNames, text: String) {
        
        let size = CGSize(width: self.frame.height / 1.6, height: self.frame.height / 1.6)
        let frame = CGRect(origin: .zero, size: size)
        
        let rewardView = EquipmentView(frame: frame)
        rewardView.configure(image: imageName, text: text)
        
        self.addSubview(rewardView)
        rewardView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            rewardView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            rewardView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: -self.frame.width/4),
            rewardView.heightAnchor.constraint(equalToConstant: size.height),
            rewardView.widthAnchor.constraint(equalToConstant: size.width),
        ])
    }
    
    private func firstBorder(size: CGSize) {
        let rectangle = UIView(frame: .zero)

        self.addSubview(rectangle)
        rectangle.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            rectangle.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            rectangle.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            rectangle.heightAnchor.constraint(equalToConstant: size.height),
            rectangle.widthAnchor.constraint(equalToConstant: size.width)
        ])
        
        rectangle.layer.cornerRadius = 7
        rectangle.backgroundColor = .black.withAlphaComponent(0.5)
    }
}
