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
    private var progressView: TaskProgressView!
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
        let height: CGFloat = self.frame.height/4
        let width: CGFloat = self.frame.width/1.9
        let size = CGSize(width: width, height: height)
        let frame = CGRect(origin: .zero, size: size)
        
        let progressView = TaskProgressView(frame: frame)

        self.addSubview(progressView)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            progressView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -self.frame.height/2),
            progressView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: self.frame.width/12),
            progressView.heightAnchor.constraint(equalToConstant: height),
            progressView.widthAnchor.constraint(equalToConstant: width),
        ])
        
        progressView.goal = 7
        progressView.completed = 3
        progressView.trackTintColor = .brown
        progressView.progressTintColor = .systemGreen
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
