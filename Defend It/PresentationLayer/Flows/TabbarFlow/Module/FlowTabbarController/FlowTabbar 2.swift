//
//  FlowTabbar.swift
//  Defend It
//
//  Created by Роман Сенкевич on 28.07.22.
//

import UIKit

class FlowTabbar: UITabBar {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        isTranslucent    = false
        shadowImage        = UIImage()
    }
}
