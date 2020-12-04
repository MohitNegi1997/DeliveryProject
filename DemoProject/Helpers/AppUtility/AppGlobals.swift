//
//  AppGlobals.swift
//  DemoProject
//
//  Created by Mohit on 29/11/20.
//  Copyright © 2020 Mohit. All rights reserved.
//

import Foundation
import UIKit

/// Print Debug
func print_debug<T>(_ obj : T) {
    #if DEBUG
        print(obj)
    #endif
}

/// Is Simulator or Device
var isSimulatorDevice: Bool {

    var isSimulator = false
    #if arch(i386) || arch(x86_64)
        //simulator
        isSimulator = true
    #endif
    return isSimulator
}

var isDeviceIPad : Bool {
    return UIDevice.current.userInterfaceIdiom == .pad
}

/// Is this iPhone X or not or iphonexmax
func isDeviceIsIphoneX() -> Bool {
    if UIDevice().userInterfaceIdiom == .phone {
        switch UIScreen.main.nativeBounds.height {
        case 1136: return false
        case 1334: return false
        case 2208: return false
        case 2436: return true
        case 2688: return true
        default: return false
        }
    }
    return false
}

var isDeviceIPhone5: Bool {
    if UIDevice().userInterfaceIdiom == .phone {
        switch UIScreen.main.nativeBounds.height {
        case 1136: return true
        case 1334: return false
        case 2208: return false
        case 2436: return false
        case 2688: return false
        default: return false
        }
    }
    return false
}

//Check User Token
var isUserLoggedin: Bool {
    let token = AppUserDefaults.value(forKey: .accesstoken).stringValue
    if !token.isEmpty {
        return true
    } else {
        return false
    }
}

//Set App According to user type
var userType: UserType? {
    get {
        if let userDefaultValue = AppUserDefaults.value(forKey: .userType).string {
            let type = UserType(rawValue: userDefaultValue)
            return type
        } else {
            return nil
        }
    }
    set {
        AppUserDefaults.save(value: newValue?.rawValue ?? "", forKey: .userType)
    }
}
