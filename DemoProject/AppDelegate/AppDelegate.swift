//
//  AppDelegate.swift
//  DemoProject
//
//  Created by Mohit on 29/11/20.
//  Copyright © 2020 Mohit. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    static let shared = UIApplication.shared.delegate as! AppDelegate
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.goToFirstScreen()
        return true
    }
}

extension AppDelegate {
    
    private func goToFirstScreen() {
        if let userType = userType {
            switch userType {
            case .admin: AppRouter.goToAdminHomeVC()
            case .vendor: AppRouter.goToVendorHomeVC()
            case .deliveryBoy: AppRouter.goToDeliveryBoyHomeVC()
            }
        } else {
            AppRouter.goToLogin()
        }
    }
}

