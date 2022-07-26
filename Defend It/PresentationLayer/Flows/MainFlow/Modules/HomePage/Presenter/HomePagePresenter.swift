// 
//  HomePagePresenter.swift
//  Defend It
//
//  Created by MacBook Pro on 16.03.22.
//

import Foundation

class HomePagePresenter: HomePageViewOutput, HomePageInteractorOutput {
    
    weak var view: HomePageViewInput!
    weak var coordinator: HomePageViewCoordinatorOutput!
    var interactor: HomePageInteractorInput!
    
    func onStartBattle() {
        coordinator.onStartBattle?()
    }
    
}
