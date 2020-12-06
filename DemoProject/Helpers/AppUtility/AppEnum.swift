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
enum UserType: String {
    case admin, vendor, deliveryBoy
    
    var text: String {
        switch self {
        case .admin: return StringConstants.admin.localized
        case .vendor: return StringConstants.vendor.localized
        case .deliveryBoy: return StringConstants.deliveryBoy.localized
        }
    }
}

//MARK:- PickerType
enum PickerType {
    case none
    case loginPicker
    case statusPicker
    case deliveryBoyPicker
}

//MARK:- Vendor Side Menu Enum
enum VendorSideMenu {
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
    
    var icon: UIImage? {
        switch self {
        case .home: return AppImage.homeImg
        case .vendorForm: return AppImage.vendorFormImg
        case .logout: return AppImage.logoutImg
        }
    }
}

//MARK:- Admin Side Menu Enum
enum AdminSideMenu {
    case home, graph, userCreation, setting, logout
    
    var text: String {
        switch self {
        case .home: return StringConstants.home.localized
        case .graph: return StringConstants.graph.localized
        case .userCreation: return StringConstants.userCreation.localized
        case .setting: return StringConstants.setting.localized
        case .logout: return StringConstants.logout.localized
        }
    }
    
    var navigation: UIViewController? {
        switch self {
        case .home: return nil
        case .graph: return nil
        case .userCreation:
            let nextVC = UserCreationVC.instantiate(fromAppStoryboard: .admin)
            return nextVC
        case .setting:
            let nextVC = SettingVC.instantiate(fromAppStoryboard: .admin)
            return nextVC
        case .logout: return nil
        }
    }
    
    var icon: UIImage? {
        switch self {
        case .home: return AppImage.homeImg
        case .graph: return AppImage.graphImg
        case .setting: return AppImage.settingImg
        case .userCreation: return AppImage.userCreationImg
        case .logout: return AppImage.logoutImg
        }
    }
}

//MARK:- Delivery Side Menu Enum
enum DeliverySideMenu {
    case home, pendingTask, completedTask, logout
    
    var text: String {
        switch self {
        case .home: return StringConstants.home.localized
        case .logout: return StringConstants.logout.localized
        case .pendingTask: return StringConstants.pendingTask.localized
        case .completedTask: return StringConstants.completedTask.localized
        }
    }
    
    var navigation: UIViewController? {
        switch self {
        case .home: return nil
        case .logout: return nil
        case .pendingTask:
            let nextVC = DeliveryStatusVC.instantiate(fromAppStoryboard: .deliveryBoy)
            nextVC.screenType = .pending
            return nextVC
        case .completedTask:
            let nextVC = DeliveryStatusVC.instantiate(fromAppStoryboard: .deliveryBoy)
            nextVC.screenType = .completed
            return nextVC
        }
    }
    
    var icon: UIImage? {
        switch self {
        case .home: return AppImage.homeImg
        case .logout: return AppImage.logoutImg
        case .pendingTask: return AppImage.pendingTaskImg
        case .completedTask: return AppImage.completedTaskImg
        }
    }
}

//MARK:- TextField Type in Application
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
    case firstName
    case lastName
    case role
    case userPhoneNo
    case userName
    case password
    
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
        case .firstName: return StringConstants.firstName.localized
        case .lastName: return StringConstants.lastName.localized
        case .role: return StringConstants.role.localized
        case .userPhoneNo: return StringConstants.userPhoneNo.localized
        case .userName: return StringConstants.userName.localized
        case .password: return StringConstants.userPassword.localized
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
        case .firstName: return StringConstants.enterFirstNamePlaceholder.localized
        case .lastName: return StringConstants.enterLastNamePlaceholder.localized
        case .role: return StringConstants.chooseRolePlaceholder.localized
        case .userPhoneNo: return StringConstants.phoneNumberPlaceholder.localized
        case .userName: return StringConstants.enter_User_Name.localized
        case .password: return StringConstants.enter_Password.localized
        }
    }
}

//MARK:- VendorForm Enum
enum VendorFormType {
//    case requiredFields
    case name(TextFieldType)
    case consignee(TextFieldType)
    case consigneeContactDetail(TextFieldType)
    case location
    case dimensions
    case parcelDetail(TextFieldType)
    case weight(TextFieldType)
    case instructions(TextFieldType)
    case refrigerationRequried
    case pickupTime(TextFieldType)
    case pickupDate(TextFieldType)
    case deliveryDate(TextFieldType)
    case deliveryTime(TextFieldType)
    case buttons
    
    static func getDataSource() -> [VendorFormType] {
        let dataSource: [VendorFormType] = [.name(.name),.consignee(.consignee),
                                            .consigneeContactDetail(.consigneeContactDetail), location,
                                            .parcelDetail(.parcelDetail),.dimensions,.weight(.weight),
                                            .instructions(.instructions),.refrigerationRequried,
                                            .pickupTime(.pickupTime),.pickupDate(.pickupDate),
                                            .deliveryTime(.deliveryTime),.deliveryDate(.deliveryDate),.buttons]
        return dataSource
    }
}

//MARK:- UserCreation Enum
enum UserCreationType {
    case firstName(TextFieldType)
    case lastName(TextFieldType)
    case chooseRole(TextFieldType)
    case phoneNo(TextFieldType)
    case userName(TextFieldType)
    case password(TextFieldType)
    case address
    case button
    
    static func getDataSource() -> [UserCreationType] {
        let dataSource: [UserCreationType] = [.firstName(.firstName),.lastName(.lastName),
                                              .chooseRole(.role),.phoneNo(.userPhoneNo),
                                              .userName(.userName),.password(.password),
                                              .address,.button]
        return dataSource
    }
}

//MARK:- Filter Enum
enum FilterType {
    case date, deliveryBoyNames, status, none
    
    var text: String {
        switch self {
        case .date: return StringConstants.date.localized
        case .deliveryBoyNames: return StringConstants.deliveryBoyNames.localized
        case .status: return StringConstants.status.localized
        case .none: return ""
        }
    }
    
    var pickerType: PickerType {
        switch self {
        case .date: return .none
        case .none: return .none
        case .status: return .statusPicker
        case .deliveryBoyNames: return .deliveryBoyPicker
        }
    }
    
    static func getStatusDataSource() -> [OrderStatus] {
        let dataSource: [OrderStatus] = [.notCollected, .onRouteCollection,
                                         .collected, .onRouteDelivery,
                                         .delivered, .completed, .notCompleted]
        return dataSource
    }
}

//MARK:- OrderStatus Enum
enum OrderStatus {
    case notCollected, onRouteCollection, collected, onRouteDelivery, delivered, completed, notCompleted
    
    var text: String {
        switch self {
        case .notCollected: return StringConstants.notCollected.localized
        case .onRouteCollection: return StringConstants.onRouteCollection.localized
        case .collected: return StringConstants.collected.localized
        case .onRouteDelivery: return StringConstants.onRouteDelivery.localized
        case .delivered: return StringConstants.delivered.localized
        case .completed: return StringConstants.completed.localized
        case .notCompleted: return StringConstants.notCompleted.localized
        }
    }
}

//MARK:- DeliveryBoy Screen Type
enum OrderScreenType {
    case pending, completed
    
    var text: String {
        switch self {
        case .pending: return StringConstants.pendingTask.localized
        case .completed: return StringConstants.completedTask.localized
        }
    }
}
