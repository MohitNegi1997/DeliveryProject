//
//  VenderFormModel.swift
//  DemoProject
//
//  Created by Mohit on 02/12/20.
//  Copyright © 2020 Mohit. All rights reserved.
//

import Foundation

class VendorFormModel {
    
    //MARK:- Shared Instance
    static let shared = VendorFormModel()
    
    //MARK:- Properties
    var name: String = ""
    var consignee: String = ""
    var phoneNo: String = ""
    var pickupAddress: String = ""
    var deliveryAddress: String = ""
    var parcelDetail: String = ""
    var dimensions: Dimensions = Dimensions.shared
    var weight: String = ""
    var refrigerationRequired: Bool = false
    var instructions: String = ""
    var pickUpTime: String = ""
    var pickUpDate: String = ""
    var deliveryTime: String = ""
    var deliveryDate: String = ""
    
    //MARK:- Init
    private init(){}
}

class Dimensions {
    
    //MARK:- Shared Instance
    static let shared = Dimensions()
    
    //MARK:- Properties
    var length: String = ""
    var breadth: String = ""
    var height: String = ""
    
    //MARK:- Init
    private init() {}
}
