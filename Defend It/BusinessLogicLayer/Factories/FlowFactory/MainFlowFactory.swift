//
//  MainFlowFactory.swift
//  Defend It
//
//  Created by Роман Сенкевич on 26.07.22.
//

import Foundation

protocol MainFlowFactory {
    
    func produceHomePageOutput() -> HomePageViewCoordinatorOutput
    func produceBagOutput() -> BagViewCoordinatorOutput
}
