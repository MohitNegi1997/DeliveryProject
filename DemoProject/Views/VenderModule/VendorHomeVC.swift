//
//  VenderHomeVC.swift
//  DemoProject
//
//  Created by Mohit on 01/12/20.
//  Copyright © 2020 Mohit. All rights reserved.
//

import UIKit

struct VendorData {
    var name: String
    var distance: String
    var time: String
    var status: String
}

class VendorHomeVC: BaseVC {
    
    private let orderDataSource: [VendorData] = [VendorData(name: "Mohit", distance: "142Km", time: "10:30 AM", status: "Not Completed"),
    VendorData(name: "Aman", distance: "10Km", time: "4:45 PM", status: "Not Completed")]
    
    //MARK:- IBOutlets
    @IBOutlet weak var orderPlaceTblView: UITableView!
    
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
        self.setupTblView()
        self.setupNavigation()
    }
    
    private func setupNavigation() {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationBarTitle = self.safeUserType.text
        self.addLeftNavigationItems(navigationItems: [.sideMenu])
        self.addActionFor(navigationItem: .sideMenu, selector: #selector(self.openSideMenu))
        self.removeNavigationBarBottomLine()
    }
    
    private func setupTblView() {
        self.registerCell()
        self.orderPlaceTblView.delegate = self
        self.orderPlaceTblView.dataSource = self
    }
    
    private func registerCell() {
        self.orderPlaceTblView.registerCell(with: OrderStatusCell.self)
    }

    
    //MARK:- Public Methods
    
    //MARK:- Selector
    @objc func openSideMenu() {
        MenuC.sharedInstance.toggleMenu(navC: self.navigationController)
    }
}

//MARK:- UITableViewDelegate + DataSource
extension VendorHomeVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.orderDataSource.endIndex
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(with: OrderStatusCell.self, indexPath: indexPath)
        cell.configureCell(with: self.orderDataSource[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vendorFormVC = VendorFormVC.instantiate(fromAppStoryboard: .vendor)
        vendorFormVC.isDataAvailable = false
        self.push(vendorFormVC)
    }
}
