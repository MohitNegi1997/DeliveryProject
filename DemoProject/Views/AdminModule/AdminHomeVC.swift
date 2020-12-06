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
    private var toolBar: UIToolbar? = nil
    private var pickerView: UIPickerView? = nil

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
    
    private func showPickerView() {
        if self.pickerView == nil {
            self.pickerView = UIPickerView.init()
            self.pickerView?.delegate = self
            self.pickerView?.dataSource = self
            self.pickerView?.backgroundColor = AppColors.blackColor
            self.pickerView?.setValue(AppColors.whiteColor, forKey: "textColor")
            self.pickerView?.autoresizingMask = .flexibleWidth
            self.pickerView?.contentMode = .center
            self.pickerView?.frame = CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height + 300, width: UIScreen.main.bounds.size.width, height: 300)
            self.view.addSubview(self.pickerView!)
            //ToolBar
            self.toolBar = UIToolbar.init(frame: CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height + 300, width: UIScreen.main.bounds.size.width, height: 40))
            self.toolBar?.isTranslucent = true
            let doneBtn = UIBarButtonItem(title: StringConstants.done.localized, style: .done, target: self, action: #selector(onDoneButtonTapped))
            let cancelBtn = UIBarButtonItem(title: StringConstants.cancel.localized, style: .plain, target: self, action: #selector(onCancelBtnTapped))
            doneBtn.tintColor = AppColors.whiteColor
            cancelBtn.tintColor = AppColors.whiteColor
            let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            self.toolBar?.items = [cancelBtn, flexibleSpace, doneBtn]
            self.toolBar?.barTintColor = AppColors.themeColor
            self.view.addSubview(toolBar!)
            self.showPickerViewWithAnimation()
        }
    }
    
    private func showPickerViewWithAnimation() {
        if self.pickerView != nil {
            UIView.animate(withDuration: 0.5) {
                self.pickerView?.frame.origin.y = UIScreen.main.bounds.size.height - 300
                self.toolBar?.frame.origin.y = UIScreen.main.bounds.size.height - 300
            }
        }
    }
    
    private func hidePickerViewWithAnimation() {
        if self.pickerView != nil {
            UIView.animate(withDuration: 0.5, animations: {
                self.pickerView?.frame.origin.y = UIScreen.main.bounds.size.height + 200
                self.toolBar?.frame.origin.y = UIScreen.main.bounds.size.height + 200
            }) { (complete) in
                self.toolBar?.removeFromSuperview()
                self.pickerView?.removeFromSuperview()
                self.pickerView = nil
                self.toolBar = nil
            }
        }
    }
    
    private func openDatePicker() {
        let datePickerVC = DatePickerVC.instantiate(fromAppStoryboard: .vendor)
        datePickerVC.minDate = Date()
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
    
    //MARK:- Public Methods
    
    //MARK:- Selectors
    @objc func openSideMenu() {
        MenuC.sharedInstance.toggleMenu(navC: self.navigationController)
    }
    
    @objc func onDoneButtonTapped() {
        self.hidePickerViewWithAnimation()
    }
    
    @objc func onCancelBtnTapped() {
        self.hidePickerViewWithAnimation()
        self.selectedFilter = .none
        self.adminHomeTblView.reloadData()
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
            case .status: self.showPickerView()
            case .date: self.openDatePicker()
            case .deliveryBoyNames: self.showPickerView()
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

//MARK:- PickerViewDelegate & DataSource
extension AdminHomeVC: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
        
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch self.selectedFilter {
        case .status: return self.statusFilterDataSource.endIndex
        case .deliveryBoyNames: return self.deliveryBoyDataSource.endIndex
        default: return 0
        }
    }
        
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch self.selectedFilter {
        case .deliveryBoyNames: return self.deliveryBoyDataSource[row]
        case .status: return self.statusFilterDataSource[row].text
        default: return ""
        }
    }
        
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
    }
}
