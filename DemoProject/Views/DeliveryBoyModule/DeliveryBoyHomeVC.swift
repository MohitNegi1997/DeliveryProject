//
//  DeliveryBoyHomeVC.swift
//  DemoProject
//
//  Created by Mohit on 06/12/20.
//  Copyright © 2020 Mohit. All rights reserved.
//

import UIKit

class DeliveryBoyHomeVC: BaseVC {

    //MARK:- Properties
    
    //MARK:- IBOutlets
    
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialSetup()
    }
    
    deinit {
        print_debug("DeliveryBoyHomeVC deinit")
    }
    
    //MARK:- Private Methods
    private func initialSetup() {
        self.setupFonts()
        self.setupColors()
        self.localizedView()
        self.setupNavigation()
    }
    
    private func setupFonts() {
        
    }
    
    private func setupColors() {
        self.view.backgroundColor = AppColors.homeScreenBgColor
    }
    
    private func localizedView() {
        
    }
    
    private func setupNavigation() {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationBarTitle = self.safeUserType.text
        self.addLeftNavigationItems(navigationItems: [.sideMenu])
        self.addActionFor(navigationItem: .sideMenu, selector: #selector(self.openSideMenu))
        self.removeNavigationBarBottomLine()
    }
    
    //MARK:- Public Methods
    
    //MARK:- Selectors
    @objc func openSideMenu() {
        MenuC.sharedInstance.toggleMenu(navC: self.navigationController)
    }

    //MARK:- IBActions

}
