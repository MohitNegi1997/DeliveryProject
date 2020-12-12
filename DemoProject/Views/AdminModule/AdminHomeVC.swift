//
//  AdminHomeVC.swift
//  DemoProject
//
//  Created by Mohit on 04/12/20.
//  Copyright © 2020 Mohit. All rights reserved.
//

import UIKit

class AdminHomeVC: BaseVC {

    //MARK:- Properties
    private let orderDataSource: [VendorData] = [VendorData(name: "Mohit", distance: "142Km", time: "10:30 AM", status: "Not Completed"),
                                                 VendorData(name: "Aman", distance: "10Km", time: "4:45 PM", status: "Not Completed")]
    private var selectedFilter: FilterType = .none
    private let statusFilterDataSource: [OrderStatus] = FilterType.getStatusDataSource()
    private let deliveryBoyDataSource: [String] = ["Mohit","Amit","Aman"]

    //MARK:- IBOutlets
    @IBOutlet weak var adminHomeTblView: UITableView!
    
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialSetup()
    }
    
    deinit {
        print_debug("AdminHomeVC deinit")
    }
    
    //MARK:- Private Methods
    private func initialSetup() {
        self.setupColors()
        self.setupTblView()
        self.setupNavigation()
    }
        
    private func setupColors() {
        self.view.backgroundColor = AppColors.homeScreenBgColor
    }
    
    private func setupTblView() {
        self.registerCell()
        self.adminHomeTblView.delegate = self
        self.adminHomeTblView.dataSource = self
    }
    
    private func registerCell() {
        self.adminHomeTblView.registerCell(with: OrderStatusCell.self)
        self.adminHomeTblView.registerHeaderFooter(with: AdminFilterHeaderView.self)
    }
    
    private func setupNavigation() {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationBarTitle = self.safeUserType.text
        self.addLeftNavigationItems(navigationItems: [.sideMenu])
        self.addActionFor(navigationItem: .sideMenu, selector: #selector(self.openSideMenu))
        self.removeNavigationBarBottomLine()
    }
    
    private func openDatePicker() {
        let datePickerVC = DatePickerVC.instantiate(fromAppStoryboard: .picker)
        datePickerVC.minDate = Date().minus(years: 1)
        datePickerVC.onTapDone = { [weak self] (date) in
            guard let _ = self else { return }
            print_debug(date)
        }
        datePickerVC.onTapCancel = { [weak self] in
            guard let self = self else { return }
            print_debug("Tap on cancel button")
            self.selectedFilter = .none
            self.adminHomeTblView.reloadData()
        }
        datePickerVC.modalPresentationStyle = .overCurrentContext
        self.present(datePickerVC, animated: false, completion: nil)
    }
    
    private func showPickerView(with dataSource: [Any]) {
        let pickerVC = PickerVC.instantiate(fromAppStoryboard: .picker)
        pickerVC.pickerType = self.selectedFilter.pickerType
        pickerVC.pickerDataSource = dataSource
        pickerVC.onTapDone = { [weak self] (pickedType) in
            guard let _ = self else { return }
            ///To do later
        }
        pickerVC.onTapCancel = { [weak self] in
            guard let self = self else { return }
            self.selectedFilter = .none
            self.adminHomeTblView.reloadData()
        }
        pickerVC.modalPresentationStyle = .overCurrentContext
        self.present(pickerVC, animated: false, completion: nil)
    }
    
    //MARK:- Public Methods
    
    //MARK:- Selectors
    @objc func openSideMenu() {
        MenuC.sharedInstance.toggleMenu(navC: self.navigationController)
    }
    
    //MARK:- IBActions
}

//MARK:- UITableViewDelegate + DataSource
extension AdminHomeVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.orderDataSource.endIndex
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueHeaderFooter(with: AdminFilterHeaderView.self)
        view.configureView(with: self.selectedFilter)
        view.onFilterTapped = { [weak self] type in
            guard let self = self else { return }
            self.selectedFilter = type
            self.adminHomeTblView.reloadData()
            switch type {
            case .status: self.showPickerView(with: self.statusFilterDataSource)
            case .date: self.openDatePicker()
            case .deliveryBoyNames: self.showPickerView(with: self.deliveryBoyDataSource)
            case .none: return
            }
        }
        return view
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(with: OrderStatusCell.self, indexPath: indexPath)
        cell.configureCell(with: self.orderDataSource[indexPath.row])
        return cell
    }
     
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let completeTaskVC = CompleteTaskDetailVC.instantiate(fromAppStoryboard: .admin)
        self.push(completeTaskVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.tableView(tableView, heightForRowAt: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0
    }
}
