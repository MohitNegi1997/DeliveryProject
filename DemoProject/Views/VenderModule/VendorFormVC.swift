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
    private let vendorDataSource: [VendorFormType] = VendorFormType.getDataSource()
    public var isDataAvailable: Bool = true
    
    //MARK:- IBOutlets
    @IBOutlet weak var vendorFormTblView: UITableView!
    
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialSetup()
    }
    
    deinit {
        print_debug("VendorForm Deinit")
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
        self.vendorFormTblView.registerCell(with: AddressCell.self)
        self.vendorFormTblView.registerCell(with: DimensionsCell.self)
        self.vendorFormTblView.registerCell(with: RefrigerationRequiredCell.self)
        self.vendorFormTblView.registerCell(with: SubmitButtonCell.self)
    }
    
    private func setupNavigation() {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationBarTitle = StringConstants.vendorForm.localized
        self.addLeftNavigationItems(navigationItems: [.back])
        self.addActionFor(navigationItem: .back, selector: #selector(self.backBtnTapped))
        self.removeNavigationBarBottomLine()
    }
    
    private func openDatePicker(time: Bool) {
        let datePickerVC = DatePickerVC.instantiate(fromAppStoryboard: .vendor)
        datePickerVC.onlyTime = time
        datePickerVC.onTapDone = { [weak self] (date) in
            guard let _ = self else { return }
            let dateFormatter = DateFormatter()
            if time {
                dateFormatter.dateFormat = Date.DateFormat.hhmma.rawValue
                print_debug(date.convertToString(dateformat: Date.DateFormat.hhmma.rawValue))
            } else {
                dateFormatter.dateFormat = Date.DateFormat.ddMMMyyyy.rawValue
                print_debug(date)
            }
        }
        datePickerVC.onTapCancel = { [weak self] in
            guard let _ = self else { return }
            print_debug("Tap on cancel button")
        }
        datePickerVC.modalPresentationStyle = .overCurrentContext
        self.present(datePickerVC, animated: false, completion: nil)
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
        switch self.vendorDataSource[indexPath.row] {
        case .location:
            let cell = tableView.dequeueCell(with: AddressCell.self, indexPath: indexPath)
            cell.configureCellForVendor(with: StringConstants.location.localized)
            return cell
        case .dimensions:
            let cell = tableView.dequeueCell(with: DimensionsCell.self, indexPath: indexPath)
            cell.configureCell()
            return cell
        case .refrigerationRequried:
            let cell = tableView.dequeueCell(with: RefrigerationRequiredCell.self, indexPath: indexPath)
            cell.configureCell()
            return cell
        case .name(let tfType),
             .consignee(let tfType),
             .consigneeContactDetail(let tfType),
             .parcelDetail(let tfType),
             .instructions(let tfType),
             .weight(let tfType),
             .deliveryDate(let tfType),
             .deliveryTime(let tfType),
             .pickupDate(let tfType),
             .pickupTime(let tfType):
            let cell = tableView.dequeueCell(with: CommonTFCell.self, indexPath: indexPath)
            cell.configureCellForVendor(with: tfType)
            cell.onTapBtn = { [weak self] in
                guard let self = self else { return }
                switch self.vendorDataSource[indexPath.row] {
                case .pickupTime, .deliveryTime: self.openDatePicker(time: true)
                case .pickupDate, .deliveryDate: self.openDatePicker(time: false)
                default: return
                }
            }
            return cell
        case .buttons:
            let cell = tableView.dequeueCell(with: SubmitButtonCell.self, indexPath: indexPath)
            cell.configureCellForVendor(isEditHidden: self.isDataAvailable)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.tableView(tableView, heightForRowAt: indexPath)
    }
}
