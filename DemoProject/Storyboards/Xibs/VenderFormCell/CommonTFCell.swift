//
//  CommonTFCell.swift
//  DemoProject
//
//  Created by Mohit on 02/12/20.
//  Copyright © 2020 Mohit. All rights reserved.
//

import UIKit

class CommonTFCell: UITableViewCell {

    //MARK:- IBOutlets
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var txtFiledView: UIView!
    @IBOutlet weak var commonTxtField: UITextField!
    @IBOutlet weak var commonBtn: UIButton!
    
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
        self.txtFiledView.round(radius: 4.0)
    }
    
    //MARK:- Private Methods
    private func setupCell() {
        self.setupFonts()
        self.setupColor()
    }
    
    private func setupFonts() {
        self.lblTitle.font = AppFonts.SF_Pro_Regular.withSize(14.0)
        self.commonTxtField.font = AppFonts.SF_Pro_Regular.withSize(13.0)
    }
    
    private func setupColor() {
        self.txtFiledView.backgroundColor = AppColors.themeColor
        self.commonTxtField.textColor = AppColors.whiteColor
        self.lblTitle.textColor = AppColors.txtLableColor
    }
    
    //MARK:- Public Methods
    public func configureCell(with textFieldType: TextFieldType) {
        self.lblTitle.text = textFieldType.text + " *"
        self.commonTxtField.setPlaceholder(with: textFieldType.placeHolder, color: AppColors.whiteColor)
        switch  textFieldType {
        case .pickupDate,.pickupTime,.deliveryTime,.deliveryDate:
            self.commonBtn.isHidden = false
        default:
            self.commonBtn.isHidden = true
        }
    }
}
