//
//  DeliveryStatusVC.swift
//  DemoProject
//
//  Created by Mohit on 06/12/20.
//  Copyright © 2020 Mohit. All rights reserved.
//

import UIKit

class DeliveryStatusVC: BaseVC {
    
    //MARK:- Properties
    private let orderDataSource: [VendorData] = [VendorData(name: "Mohit", distance: "142Km", time: "10:30 AM", status: "Not Completed"),
                                                 VendorData(name: "Aman", distance: "10Km", time: "4:45 PM", status: "Not Completed"),
                                                 VendorData(name: "Rohit", distance: "11Km", time: "10:00 AM", status: "Completed")]
    private var filteredDataSource: [VendorData] = []
    public var screenType: OrderScreenType = .pending {
        didSet {
            self.filteredDataSource = self.orderDataSource.filter({ (orderData) -> Bool in
                switch self.screenType {
                case .pending:  return (orderData.status == "Not Completed")
                case .completed:  return (orderData.status == "Completed")
                }
            })
        }
    }
    
    //MARK:- IBOutlets
    @IBOutlet weak var statusTblView: UITableView!
    
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialSetup()
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
    
    private func setupNavigation() {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationBarTitle = self.screenType.text
        self.addLeftNavigationItems(navigationItems: [.back])
        self.addActionFor(navigationItem: .back, selector: #selector(self.onTapBack))
        self.removeNavigationBarBottomLine()
    }
    
    private func setupTblView() {
        self.registerCell()
        self.statusTblView.delegate = self
        self.statusTblView.dataSource = self
    }
    
    private func registerCell() {
        self.statusTblView.registerCell(with: OrderStatusCell.self)
    }
    
    //MARK:- Public Methods
    
    //MARK:- Selectors
    @objc func onTapBack() {
        self.pop()
    }
    
    //MARK:- IBActions
    
}

//MARK:- UITableViewDelegate + DataSource
extension DeliveryStatusVC: UITableViewDelegate, UITableViewDataSource {
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filteredDataSource.endIndex
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(with: OrderStatusCell.self, indexPath: indexPath)
        cell.configureCell(with: self.filteredDataSource[indexPath.row])
        return cell
    }
     
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.tableView(tableView, heightForRowAt: indexPath)
    }
}
