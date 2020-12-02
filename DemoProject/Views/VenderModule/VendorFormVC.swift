//
//  VenderFormVC.swift
//  DemoProject
//
//  Created by Mohit on 02/12/20.
//  Copyright © 2020 Mohit. All rights reserved.
//

import UIKit

class VendorFormVC: BaseVC {

    //MARK:- Properties
    private let vendorDataSource: [TextFieldType] = [.name,.consignee,.consigneeContactDetail,.parcelDetail,.instructions, .weight, .pickupTime, .pickupDate, .deliveryTime, .deliveryDate]
    
    //MARK:- IBOutlets
    @IBOutlet weak var vendorFormTblView: UITableView!
    
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialSetup()
    }
    
    //MARK:- Private Methods
    private func initialSetup() {
        self.setupFonts()
        self.setupColors()
        self.localizedView()
        self.setupTblView()
        self.setupNavigation()
    }
    
    private func setupFonts() {
        
    }
    
    private func setupColors() {
        
    }
    
    private func localizedView() {
        
    }
    
    private func setupTblView() {
        self.registerCell()
        self.vendorFormTblView.delegate = self
        self.vendorFormTblView.dataSource = self
    }
    
    private func registerCell() {
        self.vendorFormTblView.registerCell(with: CommonTFCell.self)
    }
    
    private func setupNavigation() {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationBarTitle = StringConstants.vendorForm.localized
        self.addLeftNavigationItems(navigationItems: [.back])
        self.addActionFor(navigationItem: .back, selector: #selector(self.backBtnTapped))
        self.removeNavigationBarBottomLine()
    }
    
    //MARK:- Public Methods
    
    //MARK:- Selectors
    @objc func backBtnTapped() {
        self.pop()
    }
    
    //MARK:- IBActions

}

//MARK:- UITableViewDelegate + DataSource
extension VendorFormVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.vendorDataSource.endIndex
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(with: CommonTFCell.self, indexPath: indexPath)
        cell.configureCell(with: self.vendorDataSource[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90.0
    }
}
