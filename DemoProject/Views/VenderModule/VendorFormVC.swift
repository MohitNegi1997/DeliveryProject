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
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        CommonFunctions.disableIQKeyboard()
    }
    
    deinit {
        print_debug("VendorForm Deinit")
    }
    
    //MARK:- Private Methods
    private func initialSetup() {
        self.setupTblView()
        self.setupNavigation()
        CommonFunctions.enableIQKeybaord()
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
    
    private func openDatePicker(type: VendorFormType) {
        let datePickerVC = DatePickerVC.instantiate(fromAppStoryboard: .picker)
        switch type {
        case .pickupTime(_), .deliveryTime(_): datePickerVC.onlyTime = true
        default: datePickerVC.onlyTime = false
        }
        datePickerVC.onTapDone = { [weak self] (date) in
            guard let _ = self else { return }
            switch type {
            case .pickupTime:
                VendorFormModel.shared.pickUpTime = date.convertToString(dateformat: Date.DateFormat.hhmma.rawValue)
            case .deliveryTime:
                VendorFormModel.shared.deliveryTime = date.convertToString(dateformat: Date.DateFormat.hhmma.rawValue)
            case .pickupDate:
                VendorFormModel.shared.pickUpDate = date.convertToString(dateformat: Date.DateFormat.ddMMMyyyy.rawValue)
            case .deliveryDate:
                VendorFormModel.shared.deliveryDate = date.convertToString(dateformat: Date.DateFormat.ddMMMyyyy.rawValue)
            default: return
            }
            self?.vendorFormTblView.reloadData()
        }
        datePickerVC.onTapCancel = { [weak self] in
            guard let _ = self else { return }
            print_debug("Tap on cancel button")
        }
        datePickerVC.modalPresentationStyle = .overCurrentContext
        self.present(datePickerVC, animated: false, completion: nil)
    }
    
    private func updateTextOnTextField(with type: TextFieldType, value: String?) {
        switch type {
        case .name: VendorFormModel.shared.name = value ?? ""
        case .consignee: VendorFormModel.shared.consignee = value ?? ""
        case .consigneeContactDetail: VendorFormModel.shared.phoneNo = value ?? ""
        case .parcelDetail: VendorFormModel.shared.parcelDetail = value ?? ""
        case .weight: VendorFormModel.shared.weight = value ?? ""
        case .instructions: VendorFormModel.shared.instructions = value ?? ""
        case .pickupTime: VendorFormModel.shared.pickUpTime = value ?? ""
        case .pickupDate: VendorFormModel.shared.pickUpDate = value ?? ""
        case .deliveryTime: VendorFormModel.shared.deliveryTime = value ?? ""
        case .deliveryDate: VendorFormModel.shared.deliveryDate = value ?? ""
        default: return
        }
    }
    
    private func updateDimensionData(with value: String, type: DimensionType) {
        switch type {
        case .length: VendorFormModel.shared.dimensions.length  = value
        case .breadth: VendorFormModel.shared.dimensions.breadth  = value
        case .height: VendorFormModel.shared.dimensions.height  = value
        }
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
            return self.getLocationCell(with: tableView, for: indexPath)
        case .dimensions:
            return self.getDimensionsCell(with: tableView, for: indexPath)
        case .refrigerationRequried:
            return self.getRefrigerationRequiredCell(with: tableView, for: indexPath)
        case .buttons:
            return self.getButtonCell(with: tableView, for: indexPath)
        default:
            return self.getCommonTxtFieldCell(with: tableView, for: indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.tableView(tableView, heightForRowAt: indexPath)
    }
    
    //MARK:- Return Table Cells
    private func getCommonTxtFieldCell(with tableView: UITableView, for indexPath: IndexPath) -> CommonTFCell {
        switch self.vendorDataSource[indexPath.row] {
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
            cell.configureCellForVendor(with: tfType, value: self.vendorDataSource[indexPath.row].txtFieldValue)
            cell.handler = { [weak self] (txtFieldType, value) in
                guard let self = self else { return }
                self.updateTextOnTextField(with: txtFieldType, value: value)
            }
            cell.onTapBtn = { [weak self] in
                guard let self = self else { return }
                self.openDatePicker(type: self.vendorDataSource[indexPath.row])
            }
            return cell
        default:
            return CommonTFCell()
        }
    }
    
    private func getLocationCell(with tableView: UITableView, for indexPath: IndexPath) -> AddressCell {
        let cell = tableView.dequeueCell(with: AddressCell.self, indexPath: indexPath)
        cell.configureCellForVendor(with: StringConstants.location.localized, firstAddress: VendorFormModel.shared.pickupAddress, secondAddress: VendorFormModel.shared.deliveryAddress)
        cell.firstAddressHandler = { [weak self] (value) in
            guard let _ = self else { return }
            VendorFormModel.shared.pickupAddress = value
        }
        cell.secondAddressHanlder = { [weak self] (value) in
            guard let _ = self else { return }
            VendorFormModel.shared.deliveryAddress = value
        }
        return cell
    }
    
    private func getDimensionsCell(with tableView: UITableView, for indexPath: IndexPath) -> DimensionsCell {
        let cell = tableView.dequeueCell(with: DimensionsCell.self, indexPath: indexPath)
        cell.configureCell(length: VendorFormModel.shared.dimensions.length, breadth: VendorFormModel.shared.dimensions.breadth, height: VendorFormModel.shared.dimensions.height)
        cell.txtHandler = { [weak self] (value, type) in
            guard let self = self else { return }
            self.updateDimensionData(with: value, type: type)
        }
        return cell
    }

    private func getRefrigerationRequiredCell(with tableView: UITableView, for indexPath: IndexPath) -> RefrigerationRequiredCell {
        let cell = tableView.dequeueCell(with: RefrigerationRequiredCell.self, indexPath: indexPath)
        cell.configureCell(isRefrigerationRequired: VendorFormModel.shared.refrigerationRequired)
        cell.handler = { [weak self] (value) in
            guard let _ = self else { return }
            VendorFormModel.shared.refrigerationRequired = value
        }
        return cell
    }

    private func getButtonCell(with tableView: UITableView, for indexPath: IndexPath) -> SubmitButtonCell {
        let cell = tableView.dequeueCell(with: SubmitButtonCell.self, indexPath: indexPath)
        cell.configureCellForVendor(isEditHidden: self.isDataAvailable)
        return cell
    }
}
