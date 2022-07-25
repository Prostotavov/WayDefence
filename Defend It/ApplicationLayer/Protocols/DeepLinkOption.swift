//
//  DeepLinkOption.swift
//  Defend It
//
//  Created by Роман Сенкевич on 25.07.22.
//

import Foundation

enum DeepLinkOption {
    case feed
    
    static func build(with userActivity: NSUserActivity) -> DeepLinkOption? {
        if userActivity.activityType == NSUserActivityTypeBrowsingWeb,
            let url = userActivity.webpageURL,
            let _ = URLComponents(url: url, resolvingAgainstBaseURL: true) {
            //TODO: extract string and match with DeepLinkURLConstants
        }
        return nil
    }
    
    static func build(with dict: [String : AnyObject]?) -> DeepLinkOption? {
        return .feed
    }
}
