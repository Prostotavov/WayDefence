//
//  RectangleButton.swift
//  Defend It
//
//  Created by Роман Сенкевич on 2.09.22.
//

import UIKit

enum RectangleButtonColors {
    case green
    case yellow
    case peach
    case grey
    
    var associatedColor: UIColor {
        switch self {
        case .green: return UIColor(red: 137/255, green: 217/255, blue: 7/255, alpha: 1.0)
        case .yellow: return UIColor(red: 244/255, green: 200/255, blue: 81/255, alpha: 1.0)
        case .peach: return UIColor(red: 232/255, green: 218/255, blue: 197/255, alpha: 1.0)
        case .grey: return UIColor(red: 179/255, green: 179/255, blue: 179/255, alpha: 1.0)
        }
    }
}

class RectangleButton: UIButton {
    
    private var text: String?
    private var colour: UIColor?
    private var image: UIImage?
    
    // rectangles -start-
    private var rectangle01 = UIView(frame: .zero)
    private var rectangle02 = UIView(frame: .zero)
    // rectangles -end-
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func configure(size: CGSize, colour: RectangleButtonColors) {
        self.colour = colour.associatedColor
        firstBorder(size: size)
        secondBorder(size: size)
    }
    
    func changeColor(into colour: RectangleButtonColors) {
        rectangle02.backgroundColor = colour.associatedColor
    }

    private func firstBorder(size: CGSize) {

        self.addSubview(rectangle01)
        rectangle01.translatesAutoresizingMaskIntoConstraints = false
        rectangle01.isUserInteractionEnabled = false
        NSLayoutConstraint.activate([
            rectangle01.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            rectangle01.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            rectangle01.heightAnchor.constraint(equalToConstant: size.height),
            rectangle01.widthAnchor.constraint(equalToConstant: size.width)
        ])

        rectangle01.layer.cornerRadius = size.height * 0.05
        rectangle01.backgroundColor = UIColor(red: 0.33, green: 0.33, blue: 0.33, alpha: 1)
        rectangle01.layer.shadowRadius = 0.2
        rectangle01.layer.shadowOpacity = 0.5
        rectangle01.layer.shadowOffset = CGSize(width: 0, height: 1)
    }

    private func secondBorder(size: CGSize) {

        self.addSubview(rectangle02)
        rectangle02.translatesAutoresizingMaskIntoConstraints = false
        rectangle02.isUserInteractionEnabled = false
        let indent = size.height * 0.02
        let height = size.height - indent
        let width = size.width - indent

        let cornerRadius = height * 0.05

        NSLayoutConstraint.activate([
            rectangle02.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            rectangle02.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            rectangle02.heightAnchor.constraint(equalToConstant: height),
            rectangle02.widthAnchor.constraint(equalToConstant: width)
        ])

        rectangle02.layer.cornerRadius = cornerRadius
        rectangle02.backgroundColor = colour
    }
    
}
