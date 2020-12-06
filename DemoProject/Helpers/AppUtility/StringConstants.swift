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
    
    ///Admin Side Menu
    case graph = "Graph"
    case setting = "Setting"
    case userCreation = "User Creation"
    
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
    case firstName = "First Name"
    case lastName = "Last Name"
    case role = "Role"
    case userPhoneNo = "Phone"
    case userName = "User Name"
    case userPassword = "User Password"
    
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
    case requiredFields = "Required Fields"
    case enterFirstNamePlaceholder = "Enter First Name"
    case enterLastNamePlaceholder = "Enter Last Name"
    case chooseRolePlaceholder = "Choose Role"
    case phoneNumberPlaceholder = "Phone Number"
    
    //MARK:- DimensionsCell
    case dimensions = "Dimensions"
    case length = "Length"
    case breadth = "Breadth"
    case height = "Height"
    case cm = "cm"
    
    //MARK:- RefrigerationRequiredCell
    case refrigerationRequired = "Refrigeration Required"
    case yes = "Yes"
    case no = "No"
    
    //MARK:- SubmitButtonCell
    case placeOrder = "Place Order"
    case editOrder = "Edit Order"
    case saveChanges = "Save Changes"
    case createUser = "Create"
    
    //MARK:- AddressCell
    case location = "Location"
    case enterPickupAddress = "Enter Pickup Address"
    case enterDeliveryAddress = "Enter Delivery Address"
    case address = "Address"
    case addressPlaceHolder = "Enter Address"
    
    //MARK:- OrderStatusCell
    case deliveryDistance = "Delivery Distance"
    
    //MARK:- SettingVC
    case petrolDieselPrice = "Petrol/Diesel Price"
    case mileage = "Mileage"
    case petrolPriceUnit = "AED"
    case mileageUnit = "Km/L"
    case submit = "Submit"

    //MARK:- FilterType Enum
    case date = "Date"
    case deliveryBoyNames = "Delivery Boy Names"
    case status = "Status"
    
    //MARK:- OrderStatus Enum
    case notCollected = "Not Collected"
    case onRouteCollection = "On Route Collection"
    case collected = "Collected"
    case onRouteDelivery = "On Route Delivery"
    case delivered = "Delivered"
    case completed = "Completed"
    case notCompleted = "Not Completed"
    
    //MARK:- Session Expired
    case session_Expired = "Session Expired"
}

extension StringConstants {
    
    var localized : String {
        return self.rawValue.localized
    }
}
