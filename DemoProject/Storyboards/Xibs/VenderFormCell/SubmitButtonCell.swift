//
//  SubmitButtonCell.swift
//  DemoProject
//
//  Created by Mohit on 02/12/20.
//  Copyright © 2020 Mohit. All rights reserved.
//

import UIKit

class SubmitButtonCell: UITableViewCell {

    //MARK:- IBOutlets
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var editBtn: UIButton!
    
    //MARK:- Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupCell()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.submitBtn.round(radius: 4.0)
        self.editBtn.round(radius: 4.0)
    }
    
    //MARK:- Private Methods
    private func setupCell() {
        self.setupFonts()
        self.setupColors()
        self.localizedCell()
    }
    
    private func setupFonts() {
        self.submitBtn.titleLabel?.font = AppFonts.SF_Pro_Bold.withSize(15.0)
        self.editBtn.titleLabel?.font = AppFonts.SF_Pro_Bold.withSize(15.0)
    }
    
    private func setupColors() {
        self.submitBtn.setTitleColor(AppColors.whiteColor, for: .normal)
        self.editBtn.setTitleColor(AppColors.whiteColor, for: .normal)
        self.submitBtn.backgroundColor = AppColors.themeColor
        self.editBtn.backgroundColor = AppColors.themeColor
    }
    
    private func localizedCell() {
        self.submitBtn.setTitle(StringConstants.placeOrder.localized.uppercased(), for: .normal)
        self.editBtn.setTitle(StringConstants.editOrder.localized, for: .normal)
    }
    
    //MARK:- Public Methods
    public func configureCell(isEditHidden: Bool) {
        self.editBtn.isHidden = isEditHidden
        self.submitBtn.isHidden = !isEditHidden
    }
    
    //MARK:- IBActions
    @IBAction func submitBtnTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func editBtnTapped(_ sender: UIButton) {
        
    }
}
