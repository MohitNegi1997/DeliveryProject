//
//  SideMenuCell.swift
//  DemoProject
//
//  Created by Mohit on 01/12/20.
//  Copyright © 2020 Mohit. All rights reserved.
//

import UIKit

class SideMenuCell: UITableViewCell {

    //MARK:- IBOutlets
    @IBOutlet weak var sideMenuImgView: UIImageView!
    @IBOutlet weak var lblSideMenuTitle: UILabel!
    @IBOutlet weak var seperateView: UIView!
    
    //MARK:- Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupCell()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //MARK:- Private Method
    private func setupCell() {
        self.contentView.backgroundColor = AppColors.themeColor
        self.lblSideMenuTitle.font = AppFonts.SF_Pro_Medium.withSize(15.0)
        self.lblSideMenuTitle.textColor = AppColors.whiteColor
        self.seperateView.backgroundColor = AppColors.whiteColor
    }
    
    //MARK:- Public Method
    public func configureCell(with text: String, icon: UIImage?) {
        self.lblSideMenuTitle.text = text
        self.sideMenuImgView.image = icon
    }
}
