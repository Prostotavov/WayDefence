//
//  GameStatusBar.swift
//  Defend It
//
//  Created by Роман Сенкевич on 10.09.22.
//

import UIKit

class GameStatusBar: UIView {
    
    private var value: Int!
    
    private var valueLabel: UILabel!
    private var imageView: UIImageView!
    private var plusButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        firstBorder(size: frame.size)
        setPlusButton(size: frame.size)
        setImageView(size: frame.size)
        setValueLabel()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configure(imageName: String, value: Int, isPlusButton: Bool? = nil) {
        configureImageView(imageName: imageName)
        
    }
    
    func configureValue(value: Int) {
        valueLabel.text = "\(value)"
    }
    
    private func configureImageView(imageName: String) {
        imageView?.image = UIImage(named: imageName)
    }
    
    private func setValueLabel() {
        valueLabel = UILabel()
        
        self.addSubview(valueLabel)
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            valueLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            valueLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
        
    }
    
    private func setPlusButton(size: CGSize) {
        
        let frame = CGRect(origin: .zero, size: CGSize(width: size.height, height: size.height))
        plusButton = PlusButton(frame: frame)
        
        self.addSubview(plusButton)
        plusButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            plusButton.rightAnchor.constraint(equalTo: self.rightAnchor),
            plusButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            plusButton.heightAnchor.constraint(equalToConstant: size.height),
            plusButton.widthAnchor.constraint(equalToConstant: size.height)
        ])
        
        /// touch target
        plusButton.addTarget(self, action: #selector(plusButtonTouchUpInside), for: .touchUpInside)
        
        plusButton.addTarget(self, action: #selector(plusButtonTouchDown), for: .touchDown)
        
        plusButton.addTarget(self, action: #selector(plusButtonTouchDragExit), for: .touchDragExit)
    }
    
    @objc func plusButtonTouchUpInside() {
        UIAnimations.rapidIncreaseAndDecreaseAnimation(view: plusButton)
    }
    
    @objc func plusButtonTouchDown() {
        UIAnimations.bagButtonSizeReductionAnimation(view: plusButton)
    }
    
    @objc func plusButtonTouchDragExit() {
        UIAnimations.rapidIncreaseAndDecreaseAnimation(view: plusButton)
    }
    
    
    
    private func setImageView(size: CGSize) {
        imageView = UIImageView()
        
        self.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.leftAnchor.constraint(equalTo: self.leftAnchor),
            imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            imageView.heightAnchor.constraint(equalToConstant: size.height),
            imageView.widthAnchor.constraint(equalToConstant: size.height)
        ])
        
        imageView.layer.cornerRadius = 7
        imageView.backgroundColor = .yellow.withAlphaComponent(0.5)
        imageView.sizeToFit()
    }
    
    private func firstBorder(size: CGSize) {
        let rectangle = UIView(frame: .zero)

        self.addSubview(rectangle)
        rectangle.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            rectangle.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            rectangle.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            rectangle.heightAnchor.constraint(equalToConstant: size.height),
            rectangle.widthAnchor.constraint(equalToConstant: size.width - size.height)
        ])
        
        rectangle.layer.cornerRadius = 7
        rectangle.backgroundColor = .purple
    }
}
