//
//  AppConstants.swift
//  DemoProject
//
//  Created by Mohit on 29/11/20.
//  Copyright © 2020 Mohit. All rights reserved.
//

import Foundation

enum ValidityExression : String {
    case userName = "^[a-zA-z]{1,}+[a-zA-z0-9!@#$%&*]{2,15}"
    case email = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9-]+\\.[A-Za-z]{5,30}"
    case mobileNumber = "^[0-9]{8,10}$"
    case password = "(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[!@#$%^&*()-_=+<>?/']).{6,15}"
    case name = "^[a-zA-Z]{2,15}"
}

enum AppConstants {
    
    static var phoneNoLength: Int { return 14 }
}
