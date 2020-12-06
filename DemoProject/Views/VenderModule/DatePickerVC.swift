//
//  DatePickerVC.swift
//  DemoProject
//
//  Created by Mohit on 02/12/20.
//  Copyright © 2020 Mohit. All rights reserved.
//

import UIKit

class DatePickerVC: BaseVC {
    
    //MARK:- Properties
    var maxDate: Date?
    var minDate: Date?
    var onTapCancel: (() -> Void)?
    var onTapDone: ((Date) -> Void)?
    var onlyTime: Bool = false
    
    //MARK:- IBOutlets
    @IBOutlet weak var customDatePicker: UIDatePicker!
    @IBOutlet weak var datePickerView: UIView!
    @IBOutlet weak var toolbarView: UIView!
    @IBOutlet weak var btnDone: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var bottomViewConst: NSLayoutConstraint!
    
    //MARK:- Life cycle
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
        self.setupDatePicker()
    }
    
    private func setupFonts() {
        self.btnDone.titleLabel?.font  = AppFonts.SF_Pro_Medium.withSize(15)
        self.btnCancel.titleLabel?.font  = AppFonts.SF_Pro_Medium.withSize(15)
    }
    
    private func setupColor() {
        self.btnDone.setTitleColor(AppColors.whiteColor, for: .normal)
        self.btnCancel.setTitleColor(AppColors.whiteColor, for: .normal)
        self.toolbarView.backgroundColor = AppColors.themeColor
        self.datePickerView.backgroundColor = AppColors.blackColor
        self.customDatePicker?.setValue(AppColors.whiteColor, forKey: "textColor")
        self.customDatePicker?.setValue(false, forKeyPath: "highlightsToday")
        self.customDatePicker?.backgroundColor = .clear
    }
    
    private func localizedView() {
        self.btnDone.setTitle(StringConstants.done.localized, for: .normal)
        self.btnCancel.setTitle(StringConstants.cancel.localized, for: .normal)
    }
    
    private func setupDatePicker() {
        let currentDate = TrueTimeManager.shared.currentTime
        if #available(iOS 13.4, *) { customDatePicker?.preferredDatePickerStyle = .wheels }
        if onlyTime {
            customDatePicker?.datePickerMode = .time
        } else {
            customDatePicker?.datePickerMode = .date
        }
        if let minimumDate = self.minDate {

        } else {
            customDatePicker?.minimumDate = currentDate
        }
    }
    
    private func donebtnActionForDatePicker() {
        self.dismiss(animated: true, completion: {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd/yy HH:mm"
            let dateValue = dateFormatter.date(from: dateFormatter.string(from: self.customDatePicker.date))
            if let date = dateValue {
                self.onTapDone?(date)
            } else {
                CommonFunctions.showToastWithMessage("Something wrong")
                self.onTapCancel?()
            }
        })
    }
    
    //MARK:- IBAction
    @IBAction func tapCancel(_ sender: UIButton) {
        self.dismiss(animated: true, completion: {
            self.onTapCancel?()
        })
    }
    
    @IBAction func tapDone(_ sender: UIButton) {
        self.donebtnActionForDatePicker()
    }
}
