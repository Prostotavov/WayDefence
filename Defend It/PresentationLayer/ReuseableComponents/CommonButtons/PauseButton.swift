//
//  PauseButton.swift
//  Defend It
//
//  Created by Роман Сенкевич on 10.09.22.
//

import UIKit

class PauseButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        firstBorder(size: frame.size)
        imageView(size: frame.size)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
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
        rectangle.backgroundColor = .purple
    }
    
    private func imageView(size: CGSize) {
        
        let image = UIImage(named: "bag")
        
        let imageView = UIImageView(image: image)

        self.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = false
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            imageView.heightAnchor.constraint(equalToConstant: size.height * 1.4),
            imageView.widthAnchor.constraint(equalToConstant: size.height * 1.4)
        ])
        
        imageView.sizeToFit()
    }
}
