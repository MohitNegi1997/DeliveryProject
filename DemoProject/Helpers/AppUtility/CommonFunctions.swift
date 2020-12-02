//
//  CommonFunctions.swift
//  DemoProject
//
//  Created by Mohit on 29/11/20.
//  Copyright © 2020 Mohit. All rights reserved.
//

import Foundation
import Toaster
import NVActivityIndicatorView
import MobileCoreServices
import AVFoundation
import IQKeyboardManagerSwift

class CommonFunctions {
    
    /// Show Toast With Message
    static func showToastWithMessage(_ msg: String, completion: (() -> Swift.Void)? = nil) {
        DispatchQueue.mainQueueAsync {
            ToastView.appearance().font = AppFonts.SF_Pro_Regular.withSize(14)
            ToastView.appearance().textColor = AppColors.whiteColor
            ToastView.appearance().backgroundColor = AppColors.blackColor
            if msg.count > 60 {
                let toast = Toast(text: msg, delay: 0.3, duration: 5)
                toast.show()
            } else {
                let toast = Toast(text: msg, delay: 0.3, duration: 0.7)
                toast.show()
            }
        }
    }
    
    /// Delay Functions
    class func delay(delay: Double, closure:@escaping () -> Void) {
        let when = DispatchTime.now() + delay
        DispatchQueue.main.asyncAfter(deadline: when) {
            closure()
            
        }
    }
    
    /// Show Action Sheet With Actions Array
    class func showActionSheetWithActionArray(_ title: String?, message: String?,
                                              viewController: UIViewController,
                                              alertActionArray: [UIAlertAction],
                                              preferredStyle: UIAlertController.Style) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        
        alertActionArray.forEach { alert.addAction($0) }
        
        DispatchQueue.mainQueueAsync {
            viewController.present(alert, animated: true, completion: nil)
        }
    }
    
    /// Show Activity Loader
    class func showActivityLoader() {
        DispatchQueue.mainQueueAsync {
            if let vc = AppDelegate.shared.window?.rootViewController {
                vc.startNYLoader()
            }
        }
    }
    
    /// Hide Activity Loader
    class func hideActivityLoader() {
        DispatchQueue.mainQueueAsync {
            if let vc = AppDelegate.shared.window?.rootViewController {
                vc.stopAnimating()
            }
        }
    }
    
    //Enable IQKeyboard
    static func enableIQKeybaord() {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        IQKeyboardManager.shared.enableAutoToolbar = false
        IQKeyboardManager.shared.keyboardDistanceFromTextField = 10.0
    }
    
    static func disableIQKeyboard() {
        IQKeyboardManager.shared.enable = false
        IQKeyboardManager.shared.enableAutoToolbar = false
    }
    
    
    /// Show Action Sheet With Actions Array
    class func showActivityViewController(_ content: [Any],
                                          viewController: UIViewController) {
        let activityViewController = UIActivityViewController(activityItems: content, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = viewController.view
        
        DispatchQueue.mainQueueAsync {
            viewController.present(activityViewController, animated: true, completion: nil)
        }
    }
    
    /// LogoutProcess
    class func logoutUserProcess() {
        AppUserDefaults.removeAllValues()
        userType = nil
        AppRouter.goToLogin()
    }
    
    class func verifyUrl (urlString: String?) -> Bool {
        if let urlString = urlString {
            if let url = NSURL(string: urlString) {
                return UIApplication.shared.canOpenURL(url as URL)
            }
        }
        return false
    }
    
    class func convertURLToData(url: URL) -> Data {
        do {
            let data = try Data.init(contentsOf: url)
            return data
        } catch {
            print_debug(error.localizedDescription)
            print_debug("Error: Cannot convert to data")
        }
        return Data()
    }
    
    class func alertActionWithBlueDone(title: String = "Advisor", doneTitle: String, msg : String,
                                       selfVC : UIViewController,completion: (()->())? = nil) {
        
        let alertController = UIAlertController(title: "", message: "", preferredStyle: UIAlertController.Style.alert)
        
        let titleFont = [NSAttributedString.Key.font: AppFonts.SF_Pro_Bold.withSize(20)]
        let messageFont = [NSAttributedString.Key.font: AppFonts.SF_Pro_SemiBold.withSize(16)]
        
        let titleAttrString = NSMutableAttributedString(string: title, attributes: titleFont)
        let messageAttrString = NSMutableAttributedString(string: msg, attributes: messageFont)
        
        alertController.setValue(titleAttrString, forKey: "attributedTitle")
        alertController.setValue(messageAttrString, forKey: "attributedMessage")
        let action = UIAlertAction(title: doneTitle, style: UIAlertAction.Style.destructive) { (_) in
            completion?()
        }
        
        action.setValue(UIColor.red, forKey: "titleTextColor")
        alertController.addAction(action)
        selfVC.present(alertController, animated: true, completion: nil)
    }
    
    static func convertToApiFormat(_ dict : [String : Any]) -> String {
        var data = Data()
        do {
            data = try JSONSerialization.data(withJSONObject: dict ,options: JSONSerialization.WritingOptions(rawValue: 0))
        }
        catch{
            print_debug("Something went wrong when converting array")
        }
        if let tempString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) as String?{
            
            return tempString
        }else{
            return ""
        }
    }
}
