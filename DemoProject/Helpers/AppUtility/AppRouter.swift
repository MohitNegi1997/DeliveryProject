//
//  AppRouter.swift
//  DemoProject
//
//  Created by Mohit on 29/11/20.
//  Copyright © 2020 Mohit. All rights reserved.
//

import Foundation
import UIKit

enum AppRouter {
    
    /// Go To Login Screen
    static func goToLogin() {
        let mainViewController = ViewController.instantiate(fromAppStoryboard: .preLogin)
        let nvc = UINavigationController(rootViewController: mainViewController)
        nvc.isNavigationBarHidden = false
        UIView.transition(with: AppDelegate.shared.window!, duration: 0.33, options: UIView.AnimationOptions.transitionCrossDissolve, animations: {
            AppDelegate.shared.window?.rootViewController =  nvc
        }, completion: { (finished) in
        })
        AppDelegate.shared.window?.becomeKey()
        AppDelegate.shared.window?.makeKeyAndVisible()
    }
    
    //Go To VendorHome Screen
    static func goToVendorHomeVC() {
        let mainViewController = VendorHomeVC.instantiate(fromAppStoryboard: .vendor)
        let nvc = UINavigationController(rootViewController: mainViewController)
        nvc.isNavigationBarHidden = false
        UIView.transition(with: AppDelegate.shared.window!, duration: 0.33, options: UIView.AnimationOptions.transitionCrossDissolve, animations: {
            AppDelegate.shared.window?.rootViewController =  nvc
        }, completion: { (finished) in
        })
        AppDelegate.shared.window?.becomeKey()
        AppDelegate.shared.window?.makeKeyAndVisible()
    }
    
    //Go To VendorHome Screen
    static func goToAdminHomeVC() {
        let mainViewController = AdminHomeVC.instantiate(fromAppStoryboard: .admin)
        let nvc = UINavigationController(rootViewController: mainViewController)
        nvc.isNavigationBarHidden = false
        UIView.transition(with: AppDelegate.shared.window!, duration: 0.33, options: UIView.AnimationOptions.transitionCrossDissolve, animations: {
            AppDelegate.shared.window?.rootViewController =  nvc
        }, completion: { (finished) in
        })
        AppDelegate.shared.window?.becomeKey()
        AppDelegate.shared.window?.makeKeyAndVisible()
    }
    
    // Go To Any View Controller
    static func goToVC(viewController: UIViewController) {
        let nvc = UINavigationController(rootViewController: viewController)
        UIView.transition(with: AppDelegate.shared.window!, duration: 0.33, options: UIView.AnimationOptions.transitionCrossDissolve, animations: {
            AppDelegate.shared.window?.rootViewController = nvc
        }, completion: nil)
        AppDelegate.shared.window?.becomeKey()
        AppDelegate.shared.window?.backgroundColor = .white
        AppDelegate.shared.window?.makeKeyAndVisible()
    }
}
