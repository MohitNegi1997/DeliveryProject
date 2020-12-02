//
//  VenderHomeVC.swift
//  DemoProject
//
//  Created by Mohit on 01/12/20.
//  Copyright © 2020 Mohit. All rights reserved.
//

import UIKit

class VendorHomeVC: BaseVC {

    //MARK:- IBOutlets
    
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    deinit {
        print_debug("VenderHomeVC deinit")
    }
    
    //MARK:- Private Methods
    private func initialSetup() {
        self.setupNavigation()
    }
    
    private func setupNavigation() {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationBarTitle = self.safeUserType.text
        self.addLeftNavigationItems(navigationItems: [.sideMenu])
        self.addActionFor(navigationItem: .sideMenu, selector: #selector(self.openSideMenu))
        self.removeNavigationBarBottomLine()
    }
    
    //MARK:- Public Methods
    
    //MARK:- Selector
    @objc func openSideMenu() {
        MenuC.sharedInstance.toggleMenu(navC: self.navigationController)
    }
}
