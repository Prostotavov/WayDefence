//
//  EquipmentCell.swift
//  Defend It
//
//  Created by Роман Сенкевич on 29.08.22.
//

import UIKit

enum ImageNames: String {
    case arch = "arch"
    case blade = "blade"
    case hammer = "hammer"
    case shield = "shield"
    case diamond = "diamond"
    case flask = "flask"
    case money = "money"
}

protocol EquipmentCell: UICollectionViewCell {
    func configure(image: ImageNames, text: String)
}

class EquipmentCellImp: UICollectionViewCell, EquipmentCell {
    
    static let identifier = "EquipmentCell"
    private var label: UILabel?
    private var imageView: UIImageView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        firstBorder(size: frame.size)
        secondBorder(size: frame.size)
        thirdBorder(size: frame.size)
        fourthBorder(size: frame.size)
        setImage(size: frame.size)
        setLabel(size: frame.size)
    }
    
    private func configureLabel(text: String) {
        let strokeTextAttributes = [
          NSAttributedString.Key.strokeColor : UIColor.black,
          NSAttributedString.Key.foregroundColor : UIColor.white,
          NSAttributedString.Key.strokeWidth : -4.0,
          NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 12)]
          as [NSAttributedString.Key : Any]

        label?.attributedText = NSMutableAttributedString(string: text, attributes: strokeTextAttributes)
    }
    
    private func configureImage(image: ImageNames) {
        imageView?.image = UIImage(named: image.rawValue)
    }
    
    private func setLabel(size: CGSize) {
        label = UILabel()
        guard let label = label else {return}
        self.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
            label.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -7)
        ])
    }
    
    private func setImage(size: CGSize) {
        imageView = UIImageView()
        guard let imageView = imageView else {return}
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
        rectangle.backgroundColor = .black
    }
    
    private func secondBorder(size: CGSize) {
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
    
    private func thirdBorder(size: CGSize) {
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
    
    private func fourthBorder(size: CGSize) {
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
    
    func configure(image: ImageNames, text: String) {
        configureLabel(text: text)
        configureImage(image: image)
    }
    
    override func prepareForReuse() {
        label = nil
        imageView = nil
    }
}
