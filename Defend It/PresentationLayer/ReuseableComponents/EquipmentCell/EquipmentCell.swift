//
//  EquipmentCell.swift
//  Defend It
//
//  Created by Роман Сенкевич on 29.08.22.
//

import UIKit

class EquipmentCell: UICollectionViewCell {
    
    static let identifier = "EquipmentCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        firstBorder(size: frame.size)
        secondBorder(size: frame.size)
        thirdBorder(size: frame.size)
        fourthBorder(size: frame.size)
        setImage(size: frame.size)
        setLabel(size: frame.size)
    }
    
    func setLabel(size: CGSize) {
        let label = UILabel()
        
        self.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
            label.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -7)
        ])
        label.text = "10"
        label.font = label.font.withSize(10)
        label.textAlignment = .center
        label.textColor = .white
    }
    
    func setImage(size: CGSize) {
        let image = UIImage(named: "arch")
        let imageView = UIImageView(image: image)
        
        self.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            imageView.heightAnchor.constraint(equalToConstant: size.height - 11),
            imageView.widthAnchor.constraint(equalToConstant: size.width - 11)
        ])
        
        imageView.sizeToFit()
    }
    
    func firstBorder(size: CGSize) {
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
        rectangle.backgroundColor = .black
    }
    
    func secondBorder(size: CGSize) {
        let rectangle = UIView(frame: .zero)
        
        self.addSubview(rectangle)
        rectangle.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            rectangle.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            rectangle.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            rectangle.heightAnchor.constraint(equalToConstant: size.height - 2),
            rectangle.widthAnchor.constraint(equalToConstant: size.width - 2)
        ])
        
        rectangle.layer.cornerRadius = 5
        rectangle.backgroundColor = UIColor(red: 1, green: 0.9, blue: 0.7, alpha: 1)
    }
    
    func thirdBorder(size: CGSize) {
        let rectangle = UIView(frame: .zero)
        
        self.addSubview(rectangle)
        rectangle.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            rectangle.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            rectangle.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            rectangle.heightAnchor.constraint(equalToConstant: size.height - 8),
            rectangle.widthAnchor.constraint(equalToConstant: size.width - 8)
        ])
        
        rectangle.layer.cornerRadius = 5
        rectangle.backgroundColor = UIColor(red: 0.2, green: 0.07, blue: 0, alpha: 1)
    }
    
    func fourthBorder(size: CGSize) {
        let rectangle = UIView(frame: .zero)
        
        self.addSubview(rectangle)
        rectangle.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            rectangle.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            rectangle.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            rectangle.heightAnchor.constraint(equalToConstant: size.height - 11),
            rectangle.widthAnchor.constraint(equalToConstant: size.width - 11)
        ])
        
        rectangle.layer.cornerRadius = 4
        rectangle.backgroundColor = UIColor(red: 0.36, green: 0.18, blue: 0, alpha: 1)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
