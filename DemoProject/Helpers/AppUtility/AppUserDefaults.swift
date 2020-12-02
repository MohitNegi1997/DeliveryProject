//
//  AppUserDefaults.swift
//  DemoProject
//
//  Created by Mohit on 29/11/20.
//  Copyright © 2020 Mohit. All rights reserved.
//

import Foundation
import SwiftyJSON
import UIKit

enum AppUserDefaults {

    static func value(forKey key: Key,
                      file: String = #file,
                      line: Int = #line,
                      function: String = #function) -> JSON {

        guard let value = UserDefaults.standard.object(forKey: key.rawValue) else {

            print_debug("No Value Found in UserDefaults\nFile: \(file) \nLine Number: \(line) \nFunction: \(function)")

            return JSON.null
        }

        return JSON(value)
    }

    static func value<T>(forKey key: Key,
                      fallBackValue: T,
                      file: String = #file,
                      line: Int = #line,
                      function: String = #function) -> JSON {

        guard let value = UserDefaults.standard.object(forKey: key.rawValue) else {

            print_debug("No Value Found in UserDefaults\nFile: \(file) \nFunction: \(function)")
            return JSON(fallBackValue)
        }

        return JSON(value)
    }

    static func save(value: Any, forKey key: Key) {
        UserDefaults.standard.set(value, forKey: key.rawValue)
        UserDefaults.standard.synchronize()
    }

    static func removeValue(forKey key: Key) {

        UserDefaults.standard.removeObject(forKey: key.rawValue)
        UserDefaults.standard.synchronize()
    }

    static func removeAllValues() {
        let appDomain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: appDomain)
        UserDefaults.standard.synchronize()

    }
}

// MARK: - KEYS
//==============
extension AppUserDefaults {

    enum Key: String {
        case languageSelectionDisplayed
        case authorization
        case accesstoken
        case fullUserProfile
        case userType
        case language
        case notificationStatus
    }
}
