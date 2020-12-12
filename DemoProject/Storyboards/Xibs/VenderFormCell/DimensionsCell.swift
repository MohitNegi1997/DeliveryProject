//
//  DimensionsCell.swift
//  DemoProject
//
//  Created by Mohit on 02/12/20.
//  Copyright © 2020 Mohit. All rights reserved.
//

import UIKit

class DimensionsCell: UITableViewCell {
    
    //MARK:- Properties
    public var txtHandler: ((String, DimensionType)->Void)?
    
    //MARK:- IBOutlets
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lengthView: UIView!
    @IBOutlet weak var lengthTxtField: UITextField!
    @IBOutlet weak var breadthView: UIView!
    @IBOutlet weak var breadthTxtField: UITextField!
    @IBOutlet weak var heightView: UIView!
    @IBOutlet weak var heightTxtField: UITextField!
    
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
        self.lengthView.round(radius: 4.0)
        self.breadthView.round(radius: 4.0)
        self.heightView.round(radius: 4.0)
    }
    
    //MARK:- Private Methods
    private func setupCell() {
        self.setupFonts()
        self.setupColors()
        self.setupTextField()
    }
    
    private func setupFonts() {
        self.lblTitle.font = AppFonts.SF_Pro_Regular.withSize(14.0)
        self.lengthTxtField.font = AppFonts.SF_Pro_Regular.withSize(13.0)
        self.breadthTxtField.font = AppFonts.SF_Pro_Regular.withSize(13.0)
        self.heightTxtField.font = AppFonts.SF_Pro_Regular.withSize(13.0)
    }
    
    private func setupColors() {
        self.lengthTxtField.textColor = AppColors.whiteColor
        self.breadthTxtField.textColor = AppColors.whiteColor
        self.heightTxtField.textColor = AppColors.whiteColor
        self.lengthView.backgroundColor = AppColors.themeColor
        self.breadthView.backgroundColor = AppColors.themeColor
        self.heightView.backgroundColor = AppColors.themeColor
        self.lblTitle.textColor = AppColors.txtLableColor
    }
    
    private func setupTextField() {
        self.lengthTxtField.delegate = self
        self.breadthTxtField.delegate = self
        self.heightTxtField.delegate = self
        self.lengthTxtField.keyboardType = .decimalPad
        self.breadthTxtField.keyboardType = .decimalPad
        self.heightTxtField.keyboardType = .decimalPad
    }
    
    //MARK:- Public Methods
    public func configureCell(length: String, breadth: String, height: String) {
        self.lblTitle.text = StringConstants.dimensions.localized + " *" + "(\(StringConstants.cm.localized))"
        self.lengthTxtField.setPlaceholder(with: StringConstants.length.localized, color: AppColors.whiteColor)
        self.breadthTxtField.setPlaceholder(with: StringConstants.breadth.localized, color: AppColors.whiteColor)
        self.heightTxtField.setPlaceholder(with: StringConstants.height.localized, color: AppColors.whiteColor)
        self.lengthTxtField.text = length
        self.breadthTxtField.text = breadth
        self.heightTxtField.text = height
    }
}

//MARK:- UITextFieldDelegate
extension DimensionsCell: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let safeHandler = self.txtHandler else { return }
        if textField == self.lengthTxtField {
            safeHandler(textField.text ?? "", .length)
        } else if textField == self.breadthTxtField {
            safeHandler(textField.text ?? "", .breadth)
        } else if textField == self.heightTxtField {
            safeHandler(textField.text ?? "", .height)
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
}
