//
//  OrderStatusCell.swift
//  DemoProject
//
//  Created by Mohit on 02/12/20.
//  Copyright © 2020 Mohit. All rights reserved.
//

import UIKit

class OrderStatusCell: UITableViewCell {
    
    //MARK:- IBOutlets
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDistance: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblStatus: UILabel!

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
        self.containerView.round(radius: 5.0)
    }

    //MARK:- Private Methods
    private func setupCell() {
        self.setupFonts()
        self.setupColors()
        self.localizedCell()
    }
    
    private func setupFonts() {
        self.lblName.font = AppFonts.SF_Pro_Heavy.withSize(14.0)
        self.lblDistance.font = AppFonts.SF_Pro_Medium.withSize(14.0)
        self.lblTime.font = AppFonts.SF_Pro_Medium.withSize(14.0)
        self.lblStatus.font = AppFonts.SF_Pro_Heavy.withSize(14.0)
    }
    
    private func setupColors() {
        self.containerView.backgroundColor = AppColors.blackColor
        self.lblName.textColor = AppColors.whiteColor
        self.lblDistance.textColor = AppColors.whiteColor
        self.lblTime.textColor = AppColors.whiteColor
        self.lblStatus.textColor = AppColors.whiteColor
    }
    
    private func localizedCell() {
        
    }
    
    //MARK:- Public Methods
    public func configureCell(with data: VendorData) {
        self.lblName.text = data.name
        self.lblDistance.text = StringConstants.deliveryDistance.localized + ": \(data.distance)"
        self.lblTime.text = StringConstants.deliveryTime.localized + "\n\(data.time)"
        self.lblStatus.text = data.status.uppercased()
    }
}
