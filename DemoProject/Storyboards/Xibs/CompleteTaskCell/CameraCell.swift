//
//  CameraCell.swift
//  DemoProject
//
//  Created by Mohit on 12/12/20.
//  Copyright © 2020 Mohit. All rights reserved.
//

import UIKit

class CameraCell: UITableViewCell {

    //MARK:- Properties
    public var onTappedBtn: (()->Void)?
    
    //MARK:- IBOutlets
    @IBOutlet weak var addPhotoBtnView: UIView!
    @IBOutlet weak var addPhotoBtn: UIButton!
    @IBOutlet weak var photoView: UIView!
    @IBOutlet weak var photoImgView: UIImageView!
    
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
        self.addPhotoBtnView.round(radius: 5.0)
        self.photoView.round(radius: 5.0)
    }
    
    //MARK:- Private Methods
    private func setupCell() {
        self.setupFonts()
        self.setupColors()
    }
    
    private func setupFonts() {
        self.addPhotoBtn.titleLabel?.font = AppFonts.SF_Pro_Medium.withSize(15.0)
    }
    
    private func setupColors() {
        self.addPhotoBtn.setTitleColor(AppColors.whiteColor, for: .normal)
        self.addPhotoBtn.backgroundColor = .clear
        self.addPhotoBtnView.backgroundColor = AppColors.themeColor
    }
    
    //MARK:- Pubilc Methods
    public func configureCell(with btnTitle: String, pickedImg: UIImage?) {
        self.addPhotoBtn.setTitle("Add Photo", for: .normal)
        if let safePickedImg = pickedImg {
            self.photoView.isHidden = false
            self.photoImgView.image = safePickedImg
        } else {
            self.photoView.isHidden = true
        }
    }
    
    //MARK:- IBActions
    @IBAction func addPhotoBtnTapped(_ sender: UIButton) {
        self.onTappedBtn?()
    }
}
