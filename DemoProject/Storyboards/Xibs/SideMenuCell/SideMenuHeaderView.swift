//
//  SideMenuHeaderView.swift
//  DemoProject
//
//  Created by Mohit on 01/12/20.
//  Copyright © 2020 Mohit. All rights reserved.
//

import UIKit

class SideMenuHeaderView: UITableViewHeaderFooterView {

    //MARK:- IBOutlets
    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var seperateView: UIView!
    
    //MARK:- Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupView()
    }
    
    //MARK:- Private Methods
    private func setupView() {
        self.lblUsername.font = AppFonts.SF_Pro_Bold.withSize(18.0)
        self.lblUsername.textColor = AppColors.whiteColor
        self.seperateView.backgroundColor = AppColors.blackColor
        self.backgroundColor = AppColors.themeColor
    }
    
    //MARK:- Public Methods
    public func configureView(with userName: String) {
        self.lblUsername.text = StringConstants.hi.localized + " \(userName)"
    }
}
