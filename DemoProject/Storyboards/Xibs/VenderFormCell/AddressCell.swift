//
//  AddressCell.swift
//  DemoProject
//
//  Created by Appinventiv on 02/12/20.
//  Copyright © 2020 Mohit. All rights reserved.
//

import UIKit

class AddressCell: UITableViewCell {

    //MARK:- IBOutlets
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var firstAddressView: UIView!
    @IBOutlet weak var firstAddressTextView: UITextView!
    @IBOutlet weak var secondAddressView: UIView!
    @IBOutlet weak var secondAddressTextView: UITextView!
    
    //MARK:- Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupCell()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.firstAddressView.round(radius: 4.0)
        self.secondAddressView.round(radius: 4.0)
    }
    
    //MARK:- Private Methods
    private func setupCell() {
        self.setupFonts()
        self.setupColors()
    }
    
    private func setupFonts() {
        self.lblTitle.font = AppFonts.SF_Pro_Regular.withSize(14.0)
        self.firstAddressTextView.font = AppFonts.SF_Pro_Regular.withSize(13.0)
        self.secondAddressTextView.font = AppFonts.SF_Pro_Regular.withSize(13.0)
        self.firstAddressTextView.placeholderFont = AppFonts.SF_Pro_Regular.withSize(13.0)
        self.secondAddressTextView.placeholderFont = AppFonts.SF_Pro_Regular.withSize(13.0)
    }
    
    private func setupColors() {
        self.firstAddressTextView.textColor = AppColors.whiteColor
        self.secondAddressTextView.textColor = AppColors.whiteColor
        self.firstAddressTextView.placeholderColor = AppColors.whiteColor
        self.secondAddressTextView.placeholderColor = AppColors.whiteColor
        self.firstAddressView.backgroundColor = AppColors.themeColor
        self.secondAddressView.backgroundColor = AppColors.themeColor
        self.lblTitle.textColor = AppColors.txtLableColor
    }
    
    //MARK:- Public Methods
    public func configureCell(with text: String) {
        self.lblTitle.text = StringConstants.location.localized + " *"
        self.firstAddressTextView.placeholder = StringConstants.enterPickupAddress.localized
        self.secondAddressTextView.placeholder = StringConstants.enterDeliveryAddress.localized
    }
    
}
