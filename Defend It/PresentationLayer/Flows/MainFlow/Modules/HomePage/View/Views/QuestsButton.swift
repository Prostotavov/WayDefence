//
//  QuestsButton.swift
//  Defend It
//
//  Created by Роман Сенкевич on 5.09.22.
//

import UIKit

class QuestsButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addImageView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func addImageView() {
        let image = UIImage(named: "quests")
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
