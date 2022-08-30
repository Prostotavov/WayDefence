//
//  HomePageView.swift
//  Defend It
//
//  Created by MacBook Pro on 16.03.22.
//

import UIKit

protocol HomePageViewDelegate: AnyObject {
    func startButtonPressed()
}

class HomePageView: UIView {
    
    let startButtonHeight: CGFloat = 50
    let startButtonWidth: CGFloat = 130
    
    var startButton = UIButton()
    weak var delegate: HomePageViewDelegate!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .gray
        setStartButton()
        startButton.addTarget(self, action: #selector(startButtonPressed), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setStartButton() {
        
        self.addSubview(startButton)
        
        startButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            startButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            startButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            startButton.heightAnchor.constraint(equalToConstant: startButtonHeight),
            startButton.widthAnchor.constraint(equalToConstant: startButtonWidth)
        ])
        
        startButton.backgroundColor = .systemBlue
        startButton.setTitle("Start", for: .normal)
    }
    
    @objc func startButtonPressed() {
        delegate.startButtonPressed()
    }
    
}

//MARK: -Canvas-

import SwiftUI

struct HomePageCanvas: PreviewProvider {
    static var previews: some View {
        UIViewCanvas().edgesIgnoringSafeArea(.all)
    }
    
    struct UIViewCanvas: UIViewRepresentable {
        
        func makeUIView(context: Context) -> some UIView {
            return HomePageView(frame: CGRect.zero)
        }
        
        func updateUIView(_ uiView: UIViewType, context: Context) {
        }
    }
    
    struct UIViewControllerCanvas: UIViewControllerRepresentable {
        
        func makeUIViewController(context: Context) -> some UIViewController {
            return HomePageViewController()
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
            
        }
    }
}
