//
//  SettingVC.swift
//  DemoProject
//
//  Created by Mohit on 05/12/20.
//  Copyright © 2020 Mohit. All rights reserved.
//

import UIKit

class SettingVC: BaseVC {
    
    //MARK:- Properties
    
    //MARK:- IBOutlets
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var bgPriceView: UIView!
    @IBOutlet weak var priceTxtField: UITextField!
    @IBOutlet weak var lblPriceUnit: UILabel!
    @IBOutlet weak var lblMileage: UILabel!
    @IBOutlet weak var bgMileageView: UIView!
    @IBOutlet weak var mileageTxtField: UITextField!
    @IBOutlet weak var lblMileageUnit: UILabel!
    @IBOutlet weak var submitBtn: UIButton!
    
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialSetup()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.bgPriceView.round(radius: 5.0)
        self.bgMileageView.round(radius: 5.0)
        self.submitBtn.round()
    }
    
    //MARK:- Private Methods
    private func initialSetup() {
        self.setupFonts()
        self.setupColors()
        self.localizedView()
        self.setupNavigation()
    }
    
    private func setupFonts() {
        self.lblPrice.font = AppFonts.SF_Pro_Bold.withSize(14.0)
        self.lblMileage.font = AppFonts.SF_Pro_Bold.withSize(14.0)
        self.lblPriceUnit.font = AppFonts.SF_Pro_SemiBold.withSize(13.0)
        self.lblMileageUnit.font = AppFonts.SF_Pro_SemiBold.withSize(13.0)
        self.priceTxtField.font = AppFonts.SF_Pro_SemiBold.withSize(13.0)
        self.mileageTxtField.font = AppFonts.SF_Pro_SemiBold.withSize(13.0)
        self.submitBtn.titleLabel?.font = AppFonts.SF_Pro_Bold.withSize(15.0)
    }
    
    private func setupColors() {
        self.view.backgroundColor = AppColors.blackColor
        self.containerView.backgroundColor = .clear
        self.lblPrice.textColor = AppColors.whiteColor
        self.lblMileage.textColor = AppColors.whiteColor
        self.lblPriceUnit.textColor = AppColors.whiteColor
        self.lblMileageUnit.textColor = AppColors.whiteColor
        self.priceTxtField.textColor = AppColors.whiteColor
        self.mileageTxtField.textColor = AppColors.whiteColor
        self.submitBtn.setTitleColor(AppColors.whiteColor, for: .normal)
        self.submitBtn.backgroundColor = AppColors.themeColor
        self.bgPriceView.backgroundColor = AppColors.themeColor
        self.bgMileageView.backgroundColor = AppColors.themeColor
    }
    
    private func localizedView() {
        self.lblPrice.text = StringConstants.petrolDieselPrice.localized
        self.lblMileage.text = StringConstants.mileage.localized
        self.lblPriceUnit.text = StringConstants.petrolPriceUnit.localized
        self.lblMileageUnit.text = StringConstants.mileageUnit.localized
        self.submitBtn.setTitle(StringConstants.submit.localized.uppercased(), for: .normal)
    }
    
    private func setupNavigation() {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationBarTitle = StringConstants.setting.localized
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
    @IBAction func submitBtnTapped(_ sender: UIButton) {
        
    }
    
}
