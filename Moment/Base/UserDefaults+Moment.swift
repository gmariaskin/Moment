//
//  UserDefaults+Moment.swift
//  Moment
//
//  Created by DiOS on 29.02.2024.
//

import Foundation

private protocol AnyOptional {
    var isNil: Bool { get }
}

extension Optional: AnyOptional {
    var isNil: Bool { self == nil }
}

//@propertyWrapper
//struct UserDefault<T> {
//    let key: String
//    let defaultValue: T
//
//    var wrappedValue: T {
//        get {
//            UserDefaults.shared.object(forKey: key) as? T ?? defaultValue
//        }
//        set {
//            if let optional = newValue as? AnyOptional, optional.isNil {
//                UserDefaults.shared.removeObject(forKey: key)
//            } else {
//                UserDefaults.shared.set(newValue, forKey: key)
//            }
//        }
//    }
//}

@propertyWrapper
struct PremiumUserDefault {
    let key: String

    var wrappedValue: Bool {
        get {
            UserDefaults.shared.bool(forKey: key)
        }
        set {
            let oldValue = UserDefaults.shared.bool(forKey: key)

            UserDefaults.shared.set(newValue, forKey: key)

            if oldValue != newValue {
                DispatchQueue.main.async {
                    if newValue {
                        NotificationCenter.default.post(name: .premiumPurchased, object: nil)
                        print("♦️Premium Purchased Notification Posted")
                    } else {
                        NotificationCenter.default.post(name: .premiumExpired, object: nil)
                        print("♦️Premium Expired Notification Posted")
                    }
                }
            }
        }
    }
}

public extension UserDefaults {
    
    static var shared = UserDefaults.standard

    @PremiumUserDefault(key: AppConstants.premiumStatus)
    internal static var premiumStatus: Bool

//    @UserDefault(key: AppConstants.isFirstLaunch, defaultValue: true)
//    internal static var isFirstLaunch: Bool

    static var isPremium: Bool {
        AppConstants.forcePremium || UserDefaults.premiumStatus
    }
}
