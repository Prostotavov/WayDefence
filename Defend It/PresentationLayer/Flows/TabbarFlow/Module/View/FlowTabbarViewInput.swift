//
//  FlowTabbarViewInput.swift
//  Defend It
//
//  Created by Роман Сенкевич on 6.08.22.
//

import Foundation

protocol FlowTabbarViewInput: AnyObject {
    func displayValue(of valueType: EconomicAccountValueTypes, to value: Int)
}
