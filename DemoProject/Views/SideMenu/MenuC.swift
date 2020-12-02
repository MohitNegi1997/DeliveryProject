//
//  MenuC.swift
//  DemoProject
//
//  Created by Mohit on 01/12/20.
//  Copyright © 2020 Mohit. All rights reserved.
//

import Foundation
import UIKit

private var _sharedInstance: MenuC = MenuC()

class MenuC: NSObject {
    
    //MARK:- Properties
    weak var navigationC: UINavigationController? = nil
    var isOpen = false
    var menu: SideMenuVC!
    class var sharedInstance: MenuC {
        return _sharedInstance
    }
    
    //MARK:- Initializer
    override init() {
        self.isOpen = false
        self.menu = SideMenuVC.instantiate(fromAppStoryboard: .sideMenu)
    }
    
    // MARK:- Public Methods
    func toggleMenu(navC: UINavigationController?) {
        self.navigationC = navC
        if self.isOpen == true { // For Close Side Menu
            self.isOpen = false
            self.closeMenu()
        } else { //For Open Side Menu
            self.isOpen = true
            self.openMenu()
        }
    }
    
    //MARK:- Private Methods
    private func openMenu() {
        self.menu.view.frame = CGRect(x: -UIScreen.main.bounds.size.width, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        let rootviewC = AppDelegate.shared.window?.rootViewController
        rootviewC?.view.addSubview(menu.view)
        self.menu.view.backgroundColor = .clear
        self.menu.sideMenuTblView.reloadData()
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseIn, animations: {
            self.menu.view.layoutIfNeeded()
            self.menu.view.frame.origin = CGPoint(x: 0, y: self.menu.view.frame.origin.y)
        }) { (finished) in
            self.menu.backgroundView.backgroundColor = AppColors.blackColor.withAlphaComponent(0.5)
        }
    }
    
    private func closeMenu() {
        self.menu.view.backgroundColor = .clear
        self.menu.backgroundView.backgroundColor = .clear
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseOut, animations: {
            self.menu.view.layoutIfNeeded()
            self.menu.view.frame.origin = CGPoint(x: -UIScreen.main.bounds.size.width, y: self.menu.view.frame.origin.y)
        }) { (finished) in
            self.menu.view.removeFromSuperview()
            self.navigationC = nil
        }
    }
    

}
