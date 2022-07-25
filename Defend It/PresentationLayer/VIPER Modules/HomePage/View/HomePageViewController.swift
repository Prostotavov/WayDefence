// 
//  HomePageViewController.swift
//  Defend It
//
//  Created by MacBook Pro on 16.03.22.
//

import UIKit

class HomePageViewController: UIViewController, HomePageViewInput, HomePageViewDelegate {
    
    var output: HomePageViewOutput!
    var assembler: HomePageAssemblyProtocol = HomePageAssembly()
    
    var homePageView = HomePageView()
    
    override func loadView() {
        view = homePageView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assembler.assembly(with: self)
        homePageView.delegate = self
    }
    
    func startButtonPressed() {
        output.startGame()
    }
    
}

