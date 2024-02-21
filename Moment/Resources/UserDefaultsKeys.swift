//
//  UserDefaultsKeys.swift
//  Moment
//
//  Created by Gleb on 06.11.2023.
//

import Foundation

struct UDKeys {
   static let isFirstLaunch = "isFirstLaunch"
   static let isPremium = "isPremium"
}

extension UserDefaults {
    @objc dynamic var isPremium: Bool {
        return bool(forKey: UDKeys.isPremium)
    }
}
