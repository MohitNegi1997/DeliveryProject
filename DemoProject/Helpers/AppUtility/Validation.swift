//
//  Validation.swift
//  DemoProject
//
//  Created by Mohit on 29/11/20.
//  Copyright © 2020 Mohit. All rights reserved.
//

import Foundation

typealias ValidationResponse = (success: Bool,message: String)

class Validation {
    
    class func loginValidation(userName: String, password: String, userType: UserType?) -> ValidationResponse {
        if userName.isEmpty {
            return (false, StringConstants.username_Empty.localized)
        } else  if password.isEmpty {
            return (false, StringConstants.password_Empty.localized)
        } else if userType == nil {
            return (false, StringConstants.userType_Empty.localized)
        } else {
            return (true, "")
        }
    }
}
