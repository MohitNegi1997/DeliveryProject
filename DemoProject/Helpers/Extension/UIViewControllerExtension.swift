//
//  UIViewControllerExtension.swift
//  DemoProject
//
//  Created by Mohit on 29/11/20.
//  Copyright © 2020 Mohit. All rights reserved.
//

import Foundation
import UIKit
import NVActivityIndicatorView

extension UIViewController {
    
    ///Not using static as it won't be possible to override to provide custom storyboardID then
    class var storyboardID : String {
        return "\(self)"
    }
    
    //function to pop the target from navigation Stack
    func pop(animated:Bool = true) {
        self.navigationController?.popViewController(animated: animated)
    }
    
    //function to pop the target from navigation Stack
    func push(_ viewController: UIViewController,animated:Bool = true) {
        self.navigationController?.pushViewController(viewController, animated: animated)
    }
    
    func getParentViewController() -> UIViewController? {
        if let viewC = self.owningViewController() {
            if viewC.navigationController != nil {
                return viewC
            } else if let finalVC = viewC.owningViewController(), finalVC.navigationController != nil {
                return finalVC
            }
        }
        return nil
    }
    
    // Start Loader
    func startNYLoader() {
        let view = NVActivityIndicatorView.init(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        view.type = .ballSpinFadeLoader
        view.color = AppColors.blackColor
        view.padding = isDeviceIPad ? 450 : 170
        view.startAnimating()
        self.view.addSubview(view)
    }
    
    func stopAnimating() {
        self.view.subviews.last?.removeFromSuperview()
    }

}

extension UIResponder {
    func next<T: UIResponder>(_ type: T.Type) -> T? {
        return next as? T ?? next?.next(type)
    }
    
    func owningViewController() -> UIViewController? {
        var nextResponser = self
        while let next = nextResponser.next {
            nextResponser = next
            if let vc = nextResponser as? UIViewController {
                return vc
            }
        }
        return nil
    }
}
