//
//  WebServices.swift
//  DemoProject
//
//  Created by Mohit on 29/11/20.
//  Copyright © 2020 Mohit. All rights reserved.
//

import Foundation

var baseUrl: String = ""

extension WebServices {
    
    //End points
    enum EndPoint: String {
        case login = "user/login"
        
        var path: String {
            return baseUrl + self.rawValue
        }
    }
}
