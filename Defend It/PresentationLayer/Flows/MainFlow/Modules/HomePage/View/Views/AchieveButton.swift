//
//  AchieveButton.swift
//  Defend It
//
//  Created by Роман Сенкевич on 9.09.22.
//

import UIKit

class AchieveButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addImageView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func addImageView() {
        let image = UIImage(named: "achieve")
        let imageView = UIImageView(image: image)
        self.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 70),
            imageView.widthAnchor.constraint(equalToConstant: 70)
        ])
        imageView.sizeToFit()
    }
}
