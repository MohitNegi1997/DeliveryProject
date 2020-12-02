//
//  LoginController.swift
//  DemoProject
//
//  Created by Mohit on 01/12/20.
//  Copyright © 2020 Mohit. All rights reserved.
//

import Foundation

protocol LoginControllerDelegate: NSObject {
    func loginSuccess()
    func loginFailed(message: String)
}

class LoginController {
    
    //MARK:- Properties
    weak var delegate: LoginControllerDelegate?
    
    //MARK:- Methods
    public func requestForLogin(userName: String, password: String, userType: UserType?) {
        let validate = Validation.loginValidation(userName: userName, password: password, userType: userType)
        if validate.success {
            self.delegate?.loginSuccess()
        } else {
            self.delegate?.loginFailed(message: validate.message)
        }
    }
}
