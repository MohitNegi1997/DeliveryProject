//
//  PickerVC.swift
//  DemoProject
//
//  Created by Mohit on 06/12/20.
//  Copyright © 2020 Mohit. All rights reserved.
//

import UIKit

class PickerVC: BaseVC {

    //MARK:- Properties
    private var selectedPicker: Any?
    public var pickerType: PickerType = .loginPicker
    public var pickerDataSource: [Any] = []
    public var onTapCancel: (() -> Void)?
    public var onTapDone: ((Any) -> Void)?
    
    //MARK:- IBOutlets
    @IBOutlet weak var customPicker: UIPickerView!
    @IBOutlet weak var pickerView: UIView!
    @IBOutlet weak var toolbarView: UIView!
    @IBOutlet weak var btnDone: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var bottomViewConst: NSLayoutConstraint!
    
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialSetup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.bottomViewConst.constant = 0
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        UIView.animate(withDuration: 0.4, animations: { [weak self] in
            guard let self = self else {return}
            self.view.layoutIfNeeded()
        })
    }

    //MARK:- Private Methods
    private func initialSetup() {
        self.setupFonts()
        self.setupColor()
        self.localizedView()
        self.setupPickerView()
    }
    
    private func setupFonts() {
        self.btnDone.titleLabel?.font  = AppFonts.SF_Pro_Medium.withSize(15)
        self.btnCancel.titleLabel?.font  = AppFonts.SF_Pro_Medium.withSize(15)
    }

    private func setupColor() {
        self.btnDone.setTitleColor(AppColors.whiteColor, for: .normal)
        self.btnCancel.setTitleColor(AppColors.whiteColor, for: .normal)
        self.toolbarView.backgroundColor = AppColors.themeColor
        self.pickerView.backgroundColor = AppColors.blackColor
        self.customPicker.setValue(AppColors.whiteColor, forKey: "textColor")
        self.customPicker.backgroundColor = .clear
    }
    
    private func localizedView() {
        self.btnDone.setTitle(StringConstants.done.localized, for: .normal)
        self.btnCancel.setTitle(StringConstants.cancel.localized, for: .normal)
    }
    
    private func setupPickerView() {
        self.customPicker.delegate = self
        self.customPicker.dataSource = self
    }

    private func donebtnActionForPicker() {
        self.dismiss(animated: true, completion: {
            if let pickerdData = self.selectedPicker {
                self.onTapDone?(pickerdData)
            } else {
                self.onTapDone?(self.pickerDataSource[0])
            }
        })
    }

    //MARK:- Public Methods
    
    //MARK:- Selectors
    
    //MARK:- IBActions
    @IBAction func tapCancel(_ sender: UIButton) {
        self.dismiss(animated: true, completion: {
            self.onTapCancel?()
        })
    }
    
    @IBAction func tapDone(_ sender: UIButton) {
        self.donebtnActionForPicker()
    }
}

//MARK:- PickerViewDelegate & DataSource
extension PickerVC: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
        
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.pickerDataSource.endIndex
    }
        
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch self.pickerType {
        case .none: return ""
        case .loginPicker: return self.getLoginPicker(pickerView, titleForRow: row, forComponent: component)
        case .statusPicker: return self.getStatusPicker(pickerView, titleForRow: row, forComponent: component)
        case .deliveryBoyPicker: return self.getDeliveryBoyPicker(pickerView, titleForRow: row, forComponent: component)
        }
    }
        
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.selectedPicker = self.pickerDataSource[row]
    }
    
    //Private methods
    private func getLoginPicker(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String {
        guard let userType = self.pickerDataSource[row] as? UserType else { return "" }
        return userType.text
    }
    
    private func getStatusPicker(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String {
        guard let statusType = self.pickerDataSource[row] as? OrderStatus else { return "" }
        return statusType.text
    }

    private func getDeliveryBoyPicker(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String {
        guard let deliveryBoyName = self.pickerDataSource[row] as? String else { return "" }
        return deliveryBoyName
    }
}
