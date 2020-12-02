//
//  AppFonts.swift
//  DemoProject
//
//  Created by Mohit on 29/11/20.
//  Copyright © 2020 Mohit. All rights reserved.
//

import Foundation
import UIKit

enum DeviceType {
    case iPhone5, iPhone6, iPhonePlusSize, iPadMini, iPad_10inch, iPad_12inch
}

enum AppFonts: String {
    
    case SF_Pro_Bold = "SFProText-Bold"
    case SF_Pro_BoldItalic = "SFProText-BoldItalic"
    case SF_Pro_Heavy = "SFProText-Heavy"
    case SF_Pro_HeavyItalic = "SFProText-HeavyItalic"
    case SF_Pro_Light = "SFProText-Light"
    case SF_Pro_LightItalic = "SFProText-LightItalic"
    case SF_Pro_Medium = "SFProText-Medium"
    case SF_Pro_MediumItalic = "SFProText-MediumItalic"
    case SF_Pro_Regular = "SFProText-Regular"
    case SF_Pro_RegularItalic = "SFProText-Italic"
    case SF_Pro_SemiBold = "SFProText-Semibold"
    case SF_Pro_SemiBoldItalic = "SF-Pro-Text-SemiboldItalic"
}

extension AppFonts {
    
    //This method calculate size according to device type
    func withSize(_ fontSize: CGFloat) -> UIFont {
        switch UIScreen.main.bounds.height {
        case let x where x > 321 :
            // For iPhone  5, 5s, 5c i.e. 320
            let iPhone5x = calculateSize(fontSize, .iPhone5)
            return UIFont(name: self.rawValue, size: iPhone5x) ?? UIFont.systemFont(ofSize: iPhone5x)
            
        case let x where x > 376 :
            //For iPhone 6:  i.e. 375
            let iPhone6x = calculateSize(fontSize, .iPhone6)
            return UIFont(name: self.rawValue, size: iPhone6x) ?? UIFont.systemFont(ofSize: iPhone6x)
            
        // For iPhone 6 Plus: i.e 414
        case let x where x > 415 :
            let iPhone6Plusx = calculateSize(fontSize, .iPhonePlusSize)
            return UIFont(name: self.rawValue, size: iPhone6Plusx) ?? UIFont.systemFont(ofSize: iPhone6Plusx)
            
        // For ipad Mini
        case let x where x > 769 :
            let iPadMini = calculateSize(fontSize, .iPadMini)
            return UIFont(name: self.rawValue, size: iPadMini) ?? UIFont.systemFont(ofSize: iPadMini)
            
        // For ipad 10 inch
        case let x where x > 835 :
            let iPad_10inch = calculateSize(fontSize, .iPad_10inch)
            return UIFont(name: self.rawValue, size: iPad_10inch) ?? UIFont.systemFont(ofSize: iPad_10inch)
            
        // For ipad 12 inch
        case let x where x > 1025 :
            let iPad_12inchx = calculateSize(fontSize, .iPad_12inch)
            return UIFont(name: self.rawValue, size: iPad_12inchx) ?? UIFont.systemFont(ofSize: iPad_12inchx)
            
        default :
            let iPadMini = calculateSize(fontSize, .iPadMini)
            return UIFont(name: self.rawValue, size: iPadMini) ?? UIFont.systemFont(ofSize: iPadMini)
        }
    }
    
    func withDefaultSize() -> UIFont {
        return UIFont(name: self.rawValue, size: 12.0) ?? UIFont.systemFont(ofSize: 12.0)
    }
    
    private func calculateSize(_ fontSize:CGFloat, _ deviceType: DeviceType) -> CGFloat {
        switch deviceType {
        case .iPhone5:
            return fontSize - CGFloat(1)
        case .iPhone6:
            return fontSize
        case .iPhonePlusSize:
            return fontSize + CGFloat(1)
        case .iPadMini:
            return fontSize + fontSize * CGFloat(0.5)
        case .iPad_10inch:
            return fontSize + fontSize * CGFloat(0.6)
        case .iPad_12inch:
            return fontSize + fontSize * CGFloat(1)
        }
    }
}
