//
//  StringConstants.swift
//  DemoProject
//
//  Created by Mohit on 29/11/20.
//  Copyright © 2020 Mohit. All rights reserved.
//

import Foundation

enum StringConstants: String {
    
    //MARK:- App Title
    case demo = "Demo"
    
    //MARK:- Login Screen
    case login_Title = "Log In"
    case enter_User_Name = "Enter User's Name"
    case enter_Password = "Enter Password"
    case select_User_Type = "Please Select a User Type"
    case signin_Title = "Sign In"
    case done = "Done"
    case cancel = "Cancel"
    
    //MARK:- SideMenu Header
    case hi = "Hi"
    
    //MARK:- AppEnum
    case admin = "Admin"
    case deliveryBoy = "Delivery Boy"
    case vendor = "Vendor"
    
    ///Vender Side Menu
    case home = "Home"
    case vendorForm = "Vendor's Form"
    case logout = "Logout"
    
    //MARK:- Validation
    case username_Empty = "User's Name is Empty"
    case password_Empty = "Password is Empty"
    case userType_Empty = "User type is Empty"
    
    
    //MARK:- TextField
    case name = "Name"
    case consignee = "Consignee"
    case consigneeContactDetails = "Consignee Contact Details"
    case parcelDetails = "Parcel Details"
    case weight = "Weight (gm)"
    case instructions = "Instructions"
    case pickupTime = "Pick-Up Time"
    case pickupDate = "Pick-Up Date"
    case deliveryTime = "Delivery Time"
    case deliveryDate = "Delivery Date"
    
    case enterVendorNamePlaceholder = "Enter Vendor's Name"
    case enterConsigneeNamePlaceholder = "Enter Consignee Name"
    case enterNumberPlaceholder = "+91-Enter Number"
    case enterParcelDetailsPlaceholder = "Enter Parcel's Details"
    case enterWeightPlaceholder = "Enter Weight"
    case enterInstructionPlaceholder = "Enter Handling Instructions"
    case pickupTimePlaceholder = "Pick-Up Time:"
    case pickupDatePlaceholder = "Pick-Up Date:"
    case deliveryTimePlaceholder = "Delivery Time:"
    case deliveryDatePlaceholder = "Delivery Date:"
    
    //MARK:- Session Expired
    case session_Expired = "Session Expired"
}

extension StringConstants {
    
    var localized : String {
        return self.rawValue.localized
    }
}
