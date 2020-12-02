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
    
    //MARK:- IBOutlets
    @IBOutlet weak var sideMenuTblView: UITableView!
    @IBOutlet weak var backgroundView: UIView!

    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialSetup()
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
            case .admin: return 0
            case .vendor: return self.vendorDataSource.endIndex
            case .deliveryBoy: return 0
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
        case .admin: cell.configureCell(with: "Admin")
        case .vendor: cell.configureCell(with: self.vendorDataSource[indexPath.row].text)
        case .deliveryBoy: cell.configureCell(with: "DeliveryBoy")
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
        case .admin: return
        case .vendor:
            let nextVC = self.vendorDataSource[indexPath.row].navigation
            if let nextScene = nextVC {
                MenuC.sharedInstance.navigationC?.pushViewController(nextScene, animated: true)
            }
        case .deliveryBoy: return
        }
        MenuC.sharedInstance.toggleMenu(navC: nil)
    }
}
