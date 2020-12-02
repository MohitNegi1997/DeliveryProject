//
//  ApiKeys.swift
//  DemoProject
//
//  Created by Mohit on 29/11/20.
//  Copyright © 2020 Mohit. All rights reserved.
//

import Foundation

enum ApiKey {
    
    static var id: String { return "id" }
    
    //Basic Keys
    static var status: String { return "status" }
    static var message: String { return "message" }
    static var code: String { return "code" }
    static var contentType: String { return "content-Type" }
    static var accept: String { return "accept" }
    static var authorization: String {return "authorization"}
    static var type: String {return "type"}
    static var deviceId: String { return "deviceId" }
    static var token: String { return "token" }
    static var lang: String { return "lang" }
    static var deviceDetails: String { return "deviceDetails" }
}

//MARK:- Api Code
//=======================
enum ApiCode {
    static var success: Int { return 200 } // Success
    static var signupSuccess: Int { return 201 } // Sign up Success
    static var successEmail: Int { return 209 } // Success
    static var successMobileNumber: Int { return 210 } // Success
    static var someMembersAreAlreadyBlocked: Int { return 304 } // Success
    static var successForOTP: Int { return 304 }
    static var chooseOptionForOTP: Int { return 300 } // Choose Option For OTP
    static var unauthorizedRequest: Int { return 206 } // Unauthorized request
    static var headerMissing: Int { return 207 } // Header is missing
    static var phoneNumberAlreadyExist: Int { return 208 } // Phone number alredy exists
    static var requiredParametersMissing: Int { return 418 } // Required Parameter Missing or Invalid
    static var fileUploadFailed: Int { return 421 } // File Upload Failed
    static var pleaseTryAgain: Int { return 500 } // Please try again
    static var tokenExpired: Int { return 401 } // Token expired refresh token needed to be generated
    static var unAuthorized: Int { return 400 } // Session Expired
    
}

