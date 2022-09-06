//
//  QuestCell.swift
//  Defend It
//
//  Created by Роман Сенкевич on 5.09.22.
//

import UIKit

protocol QuestCellDelegate: AnyObject {
    func getButtonPressed()
}

protocol QuestCell: UITableViewCell {
    func setConditionLabel(text: String)
    func setRewardView(indexPath: IndexPath, imageName: EquipmentImageNames, text: String)
}

class QuestCellImp: UITableViewCell, QuestCell {
    
    static let identifier = "QuestCell"
    
    private var conditionLabel: UILabel!
    var reward: String = ""
    var progressView: String = ""
    var getButton: RectangleButton!
    weak var delegate: QuestCellDelegate!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        firstBorder()
        setProgressView()
        setGetButton()
        contentView.isUserInteractionEnabled = true
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setConditionLabel(text: String) {
        conditionLabel = UILabel()
        self.addSubview(conditionLabel)
        conditionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            conditionLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: self.frame.height/5),
            conditionLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: self.frame.width/14)
        ])
        
        conditionLabel.backgroundColor = .green
        conditionLabel.text = text
        conditionLabel.textAlignment = .center
    }
    
    private func setProgressView() {
        let rectangle = UIView(frame: .zero)

        self.addSubview(rectangle)
        rectangle.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            rectangle.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -self.frame.height/2),
            rectangle.leftAnchor.constraint(equalTo: self.leftAnchor, constant: self.frame.width/12),
            rectangle.heightAnchor.constraint(equalToConstant: self.frame.height/4),
            rectangle.widthAnchor.constraint(equalToConstant: self.frame.width/1.9),
        ])
        
        rectangle.layer.cornerRadius = 3
        rectangle.backgroundColor = .green
    }
    
    func setRewardView(indexPath: IndexPath, imageName: EquipmentImageNames, text: String) {
        
        let size = CGSize(width: self.frame.height / 2, height: self.frame.height / 2)
        let frame = CGRect(origin: .zero, size: size)
        
        let rewardView = EquipmentView(frame: frame)
        rewardView.configure(image: imageName, text: text)

        self.addSubview(rewardView)
        rewardView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            rewardView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            rewardView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -self.frame.width/3),
            rewardView.heightAnchor.constraint(equalToConstant: self.frame.height/4),
            rewardView.widthAnchor.constraint(equalToConstant: self.frame.height/4),
        ])
    }
    
    private func firstBorder() {
        let rectangle = UIView(frame: .zero)

        self.addSubview(rectangle)
        rectangle.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            rectangle.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            rectangle.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            rectangle.heightAnchor.constraint(equalTo: self.heightAnchor, constant: -self.frame.height / 5),
            rectangle.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -self.frame.width / 14)
        ])
        
        rectangle.layer.cornerRadius = 7
        rectangle.backgroundColor = .yellow
    }
}

extension QuestCellImp {
    
    func setGetButton() {
        let size = CGSize(width: self.frame.height * 1.6, height: self.frame.height * 0.9)
        let frame = CGRect(origin: .zero, size: size)
        getButton = RectangleButton(frame: frame)
        contentView.addSubview(getButton)
        
        getButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            getButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            getButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -self.frame.width / 13),
            getButton.heightAnchor.constraint(equalToConstant: size.height),
            getButton.widthAnchor.constraint(equalToConstant: size.width)
        ])
        
        getButton.configure(size: size, colour: .green)
        getButton.setTitle("Get", for: .normal)
        
        /// touch target
        getButton.addTarget(self, action: #selector(startButtonTouchUpInside), for: .touchUpInside)
        
        getButton.addTarget(self, action: #selector(startButtonTouchDown), for: .touchDown)

        getButton.addTarget(self, action: #selector(startButtonTouchDragExit), for: .touchDragExit)
        

    }
    
    @objc func startButtonTouchUpInside() {
        UIAnimations.rapidIncreaseAndDecreaseAnimation(view: getButton)
//        delegate.getButtonPressed()
    }
    
    @objc func startButtonTouchDown() {
        UIAnimations.bagButtonSizeReductionAnimation(view: getButton)
    }
    
    @objc func startButtonTouchDragExit() {
        UIAnimations.rapidIncreaseAndDecreaseAnimation(view: getButton)
    }
}
