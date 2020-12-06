//
//  FilterCollectionCell.swift
//  DemoProject
//
//  Created by Mohit on 06/12/20.
//  Copyright © 2020 Mohit. All rights reserved.
//

import UIKit

class FilterCollectionCell: UICollectionViewCell {

    //MARK:- IBOutlets
    @IBOutlet weak var parentView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var dropDownImg: UIImageView!
    
    //MARK:- Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupCell()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.containerView.round()
        self.containerView.borderWidth = 1
    }
    
    //MARK:- Private Methods
    private func setupCell() {
        self.setupFonts()
        self.setupColors()
    }
    
    private func setupFonts() {
        self.lblTitle.font = AppFonts.SF_Pro_Medium.withSize(15.0)
    }
    
    private func setupColors() {
        self.lblTitle.textColor = AppColors.whiteColor
        self.containerView.borderColor = AppColors.whiteColor
    }
    
    //MARK:- Public Methods
    public func configureCell(with filterTxt: String, isFilterSelected: Bool) {
        self.lblTitle.text = filterTxt
        self.containerView.backgroundColor = isFilterSelected ? AppColors.themeColor : AppColors.blackColor
    }
}

