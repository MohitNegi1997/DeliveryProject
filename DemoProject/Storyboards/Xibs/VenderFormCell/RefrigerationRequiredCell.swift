//
//  RefrigerationRequiredCell.swift
//  DemoProject
//
//  Created by Appinventiv on 02/12/20.
//  Copyright © 2020 Mohit. All rights reserved.
//

import UIKit

class RefrigerationRequiredCell: UITableViewCell {

    //MARK:- Properties
    public var handler: ((Bool)->Void)?
    //MARK:- IBOutlets
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var yesView: UIView!
    @IBOutlet weak var lblYes: UILabel!
    @IBOutlet weak var circleYesView: UIView!
    @IBOutlet weak var circleYesBtn: UIButton!
    @IBOutlet weak var noView: UIView!
    @IBOutlet weak var lblNo: UILabel!
    @IBOutlet weak var circleNoView: UIView!
    @IBOutlet weak var circleNoBtn: UIButton!
    
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
        self.circleYesView.round()
        self.circleNoView.round()
        self.circleYesBtn.round()
        self.circleNoBtn.round()
    }
    
    //MARK:- Private Methods
    private func setupCell() {
        self.setupFonts()
        self.setupColors()
    }
    
    private func setupFonts() {
        self.lblTitle.font = AppFonts.SF_Pro_Regular.withSize(14.0)
        self.lblYes.font = AppFonts.SF_Pro_Regular.withSize(13.0)
        self.lblNo.font = AppFonts.SF_Pro_Regular.withSize(13.0)
    }
    
    private func setupColors() {
        self.lblYes.textColor = AppColors.whiteColor
        self.lblNo.textColor = AppColors.whiteColor
        self.circleYesView.backgroundColor = AppColors.txtLableColor
        self.circleNoView.backgroundColor = AppColors.txtLableColor
        self.circleYesBtn.backgroundColor = AppColors.blackColor
        self.circleNoBtn.backgroundColor = AppColors.blackColor
        self.lblTitle.textColor = AppColors.txtLableColor
    }
    
    private func updateCircleView(value: Bool) { //Value is true for yes & false for no
        self.circleYesBtn.backgroundColor = value ? AppColors.themeColor : AppColors.blackColor
        self.circleNoBtn.backgroundColor = !value ? AppColors.themeColor : AppColors.blackColor
    }
    
    //MARK:- Public Methods
    public func configureCell(isRefrigerationRequired: Bool) {
        self.lblTitle.text = StringConstants.refrigerationRequired.localized
        self.lblYes.text = StringConstants.yes.localized
        self.lblNo.text = StringConstants.no.localized
        self.updateCircleView(value: isRefrigerationRequired)
    }
    
    //MARK:- IBActions
    @IBAction func yesBtnTapped(_ sender: UIButton) {
        self.updateCircleView(value: true)
        guard let safeHandler = self.handler else { return }
        safeHandler(true)
    }
    
    @IBAction func noBtnTapped(_ sender: UIButton) {
        self.updateCircleView(value: false)
        guard let safeHandler = self.handler else { return }
        safeHandler(false)
    }
}
