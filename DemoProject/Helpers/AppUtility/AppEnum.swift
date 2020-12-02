//
//  AppEnum.swift
//  DemoProject
//
//  Created by Mohit on 01/12/20.
//  Copyright © 2020 Mohit. All rights reserved.
//

import Foundation
import UIKit

//MARK:- Navigation
enum NavigationBarItemType {
    case back
    case sideMenu
    
    var icon: UIImage? {
        switch self {
        case .back:
            return AppImage.backBtnImg
        case .sideMenu:
            return AppImage.sideMenuImg
        }
    }
}

//MARK:- User Role
enum UserType: CaseIterable {
    case admin, vendor, deliveryBoy
    
    var text: String {
        switch self {
        case .admin: return StringConstants.admin.localized
        case .vendor: return StringConstants.vendor.localized
        case .deliveryBoy: return StringConstants.deliveryBoy.localized
        }
    }
}

enum VendorSideMenu: CaseIterable {
    case home, vendorForm, logout
    
    var text: String {
        switch self {
        case .home: return StringConstants.home.localized
        case .vendorForm: return StringConstants.vendorForm.localized
        case .logout: return StringConstants.logout.localized
        }
    }
    
    var navigation: UIViewController? {
        switch self {
        case .home: return nil
        case .vendorForm:
            let vc = VendorFormVC.instantiate(fromAppStoryboard: .vendor)
            return vc
        case .logout: return nil
        }
    }
}

enum TextFieldType {
    case name
    case consignee
    case consigneeContactDetail
    case parcelDetail
    case weight
    case instructions
    case pickupTime
    case pickupDate
    case deliveryTime
    case deliveryDate
    
    var text: String {
        switch self {
        case .name: return StringConstants.name.localized
        case .consignee: return StringConstants.consignee.localized
        case .consigneeContactDetail: return StringConstants.consigneeContactDetails.localized
        case .parcelDetail: return StringConstants.parcelDetails.localized
        case .weight: return StringConstants.weight.localized
        case .instructions: return StringConstants.instructions.localized
        case .pickupTime: return StringConstants.pickupTime.localized
        case .pickupDate: return StringConstants.pickupDate.localized
        case .deliveryTime: return StringConstants.deliveryTime.localized
        case .deliveryDate: return StringConstants.deliveryDate.localized
        }
    }
    
    var placeHolder: String {
        switch self {
        case .name: return StringConstants.enterVendorNamePlaceholder.localized
        case .consignee: return StringConstants.enterConsigneeNamePlaceholder.localized
        case .consigneeContactDetail: return StringConstants.enterNumberPlaceholder.localized
        case .parcelDetail: return StringConstants.enterParcelDetailsPlaceholder.localized
        case .weight: return StringConstants.enterWeightPlaceholder.localized
        case .instructions: return StringConstants.enterInstructionPlaceholder.localized
        case .pickupTime: return StringConstants.pickupTimePlaceholder.localized
        case .pickupDate: return StringConstants.pickupDatePlaceholder.localized
        case .deliveryTime: return StringConstants.deliveryTimePlaceholder.localized
        case .deliveryDate: return StringConstants.deliveryDatePlaceholder.localized
        }
    }
}
