//
//  CommonTFCell.swift
//  DemoProject
//
//  Created by Mohit on 02/12/20.
//  Copyright © 2020 Mohit. All rights reserved.
//

import UIKit

class CommonTFCell: UITableViewCell {
    
    //MARK:- Properties
    private var txtFieldType: TextFieldType? = nil
    public var onTapBtn: (()->Void)?
    public var handler: ((TextFieldType, String?)->Void)?

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
    public func configureCellForVendor(with textFieldType: TextFieldType, value: String) {
        self.commonTxtField.delegate = self
        self.txtFieldType = textFieldType
        self.commonTxtField.setPlaceholder(with: textFieldType.placeHolder, color: AppColors.whiteColor)
        self.commonTxtField.text = value
        switch  textFieldType {
        case .pickupDate,.pickupTime,.deliveryTime,.deliveryDate:
            self.commonBtn.isHidden = false
            self.lblTitle.text = textFieldType.text + " *"
        case .instructions,.weight:
            self.commonBtn.isHidden = true
            self.lblTitle.text = textFieldType.text
        default:
            self.commonBtn.isHidden = true
            self.lblTitle.text = textFieldType.text + " *"
        }
    }
    
    public func configureCellForUserCreation(with textFieldType: TextFieldType) {
        self.txtFieldType = textFieldType
        self.commonTxtField.delegate = self
        self.commonTxtField.setPlaceholder(with: textFieldType.placeHolder, color: AppColors.whiteColor)
        self.lblTitle.text = textFieldType.text + " *"
        self.commonBtn.isHidden = textFieldType != .role
    }
    
    //MARK:- IBActions
    @IBAction func commonBtnTapped(_ sender: UIButton) {
        self.onTapBtn?()
    }
}

//MARK:- UITextFieldDelegate
extension CommonTFCell: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        print_debug(textField.text)
        guard let handler = self.handler else { return }
        guard let safeTxtField = self.txtFieldType else { return }
        handler(safeTxtField, textField.text ?? "")
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch self.txtFieldType {
        case .consigneeContactDetail:
            self.commonTxtField.keyboardType = .numberPad
            self.commonTxtField.text = (textField.text!.count >= 4) ? (textField.text ?? "") : "+91-"
        case .weight:
            self.commonTxtField.keyboardType = .decimalPad
        default:
            self.commonTxtField.keyboardType = .asciiCapable
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch self.txtFieldType {
        case .consigneeContactDetail:
            if (self.commonTxtField.text?.count ?? 0) <= 4 {
                self.commonTxtField.text = ""
                self.commonTxtField.setPlaceholder(with: self.txtFieldType?.placeHolder ?? TextFieldType.consigneeContactDetail.placeHolder, color: AppColors.whiteColor)
            }
        default: return
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let userEnteredString = textField.text else { return false }
        let newString = (userEnteredString as NSString).replacingCharacters(in: range, with: string) as NSString
        switch self.txtFieldType {
        case .consigneeContactDetail:
            if range.length == 1 {
                return newString.length >= 4
            } else {
                return newString.length <= AppConstants.phoneNoLength
            }
        default: return true
        }
    }
}
