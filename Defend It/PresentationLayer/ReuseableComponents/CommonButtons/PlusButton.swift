//
//  PlusButton.swift
//  Defend It
//
//  Created by Роман Сенкевич on 10.09.22.
//

import UIKit

class PlusButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        firstBorder(size: frame.size)
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
            rectangle.heightAnchor.constraint(equalToConstant: size.height),
            rectangle.widthAnchor.constraint(equalToConstant: size.width)
        ])
        
        rectangle.layer.cornerRadius = 7
        rectangle.backgroundColor = .green
    }
}
