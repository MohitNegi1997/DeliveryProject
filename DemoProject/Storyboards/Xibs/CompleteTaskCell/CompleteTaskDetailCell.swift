//
//  CompleteTaskDetailCell.swift
//  DemoProject
//
//  Created by Mohit on 10/12/20.
//  Copyright © 2020 Mohit. All rights reserved.
//

import UIKit

class CompleteTaskDetailCell: UITableViewCell {

    //MARK:- IBOutlets
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var txtFiledView: UIView!
    @IBOutlet weak var commonTxtField: UITextField!

    //MARK:- LifeCycle
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
        self.setupColors()
    }
    
    private func setupFonts() {
        self.lblTitle.font = AppFonts.SF_Pro_Regular.withSize(14.0)
        self.commonTxtField.font = AppFonts.SF_Pro_Regular.withSize(13.0)
    }
    
    private func setupColors() {
        self.txtFiledView.backgroundColor = AppColors.themeColor
        self.commonTxtField.textColor = AppColors.whiteColor
        self.lblTitle.textColor = AppColors.txtLableColor
    }
    
    //MARK:- Public Methods
    public func configureCell(with txt: String) {
        self.lblTitle.text = txt
        self.commonTxtField.isUserInteractionEnabled = false
    }
}
