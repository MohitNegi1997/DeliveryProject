//
//  UITextFieldExtension.swift
//  DemoProject
//
//  Created by Mohit on 29/11/20.
//  Copyright © 2020 Mohit. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    
    
    //Return empty string if blank
    var value: String {
        return self.text ?? ""
    }
    
    //SetPlaceholder with color
    func setPlaceholder(with text: String, color: UIColor) {
        #if swift(>=4.2)
        attributedPlaceholder = NSAttributedString(
            string: text,
            attributes: [
                NSAttributedString.Key.foregroundColor: color
            ]
        )
        #elseif swift(>=4.0)
        attributedPlaceholder = NSAttributedString(
            string: text,
            attributes: [
                NSAttributedStringKey.foregroundColor: color
            ]
        )
        #else
        attributedPlaceholder = NSAttributedString(
            string: text,
            attributes: [NSForegroundColorAttributeName: color]
        )
        #endif
    }
    
    // SET BUTTON TO RIGHT VIEW
    //=========================
    func setButtonToRightView(btn : UIButton,
                              selectedImage : UIImage? = nil,
                              normalImage : UIImage? = nil,
                              size: CGSize? = nil) {
        btn.isSelected = false
        if let selectedImg = selectedImage {
            btn.setImage(selectedImg, for: .selected)
        }
        if let unselectedImg = normalImage {
            btn.setImage(unselectedImg, for: .normal)
        }
        self.rightViewMode = .always
        self.rightView = btn
        if let btnSize = size {
            self.rightView?.frame.size = btnSize
        } else {
            self.rightView?.frame.size = CGSize(width: btn.intrinsicContentSize.width+10, height: self.frame.height)
        }
    }
    
}
