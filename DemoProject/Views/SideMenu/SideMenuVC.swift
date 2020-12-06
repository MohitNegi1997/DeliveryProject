//
//  SideMenuVC.swift
//  DemoProject
//
//  Created by Mohit on 01/12/20.
//  Copyright © 2020 Mohit. All rights reserved.
//

import UIKit

class SideMenuVC: BaseVC {
    
    //MARK:- Properties
    private let vendorDataSource: [VendorSideMenu] = [.home, .vendorForm, .logout]
    private let adminDataSource: [AdminSideMenu] = [.home, .userCreation, .graph, .setting, .logout]
    private let deliveryDataSource: [DeliverySideMenu] = [.home, .pendingTask, .completedTask, .logout]
    
    //MARK:- IBOutlets
    @IBOutlet weak var sideMenuTblView: UITableView!
    @IBOutlet weak var backgroundView: UIView!

    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialSetup()
    }
    
    deinit {
        print_debug("SideMenu Deinit")
    }
    
    //MARK:- Private Methods
    private func initialSetup() {
        self.setupTblView()
        self.addTapGesture()
    }
    
    private func setupTblView() {
        self.registerCell()
        self.sideMenuTblView.delegate = self
        self.sideMenuTblView.dataSource = self
        self.sideMenuTblView.backgroundColor = AppColors.themeColor
    }

    private func registerCell() {
        self.sideMenuTblView.registerHeaderFooter(with: SideMenuHeaderView.self)
        self.sideMenuTblView.registerCell(with: SideMenuCell.self)
    }
    
    private func addTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(closeSideMenu))
        self.backgroundView.addGestureRecognizer(tapGesture)
    }
    
    private func navigateTo(vc: UIViewController?, isLogOutType: Bool ) {
        if isLogOutType {
            CommonFunctions.logoutUserProcess()
        } else {
            guard let nextScene = vc else { return }
            MenuC.sharedInstance.navigationC?.pushViewController(nextScene, animated: true)
        }
    }
    
    //MARK:- Selector
    @objc func closeSideMenu() {
        MenuC.sharedInstance.toggleMenu(navC: nil)
    }
}

//MARK:- TableViewDelegate + DataSource
extension SideMenuVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch self.safeUserType {
        case .admin: return self.adminDataSource.endIndex
        case .vendor: return self.vendorDataSource.endIndex
        case .deliveryBoy: return self.deliveryDataSource.endIndex
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueHeaderFooter(with: SideMenuHeaderView.self)
        headerView.configureView(with: "Mohit")
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(with: SideMenuCell.self, indexPath: indexPath)
        switch self.safeUserType {
        case .admin: cell.configureCell(with: self.adminDataSource[indexPath.row].text, icon: self.adminDataSource[indexPath.row].icon)
        case .vendor: cell.configureCell(with: self.vendorDataSource[indexPath.row].text, icon: self.vendorDataSource[indexPath.row].icon)
        case .deliveryBoy: cell.configureCell(with: self.deliveryDataSource[indexPath.row].text, icon: self.deliveryDataSource[indexPath.row].icon)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100.0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch safeUserType {
        case .admin:
            let nextVC = self.adminDataSource[indexPath.row].navigation
            self.navigateTo(vc: nextVC, isLogOutType: self.adminDataSource[indexPath.row] == .logout)
        case .vendor:
            let nextVC = self.vendorDataSource[indexPath.row].navigation
            self.navigateTo(vc: nextVC, isLogOutType: self.vendorDataSource[indexPath.row] == .logout)
        case .deliveryBoy:
            let nextVC = self.deliveryDataSource[indexPath.row].navigation
            self.navigateTo(vc: nextVC, isLogOutType: self.deliveryDataSource[indexPath.row] == .logout)
        }
        MenuC.sharedInstance.toggleMenu(navC: nil)
    }
}
