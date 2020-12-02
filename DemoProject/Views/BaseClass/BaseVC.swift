//
//  BaseVC.swift
//  DemoProject
//
//  Created by Mohit on 29/11/20.
//  Copyright © 2020 Mohit. All rights reserved.
//

import Foundation
import UIKit

class BaseVC: UIViewController {
    
    //MARK:- Private Properties
    private var titleLabel: UILabel = UILabel(frame: CGRect(x: 0.0, y: 0.0, width:120.0, height: 16.0))
    private var backButton: UIButton? = nil
    private var sideMenuBtn: UIButton? = nil
    
    // MARK: - Public Properties
    
    public var safeUserType: UserType {
        if let type = userType {
            return type
        } else {
            return .admin
        }
    }
    
    //  Height of status bar + navigation bar (if navigation bar exist)    
    var topbarHeight: CGFloat {
        var statusBarHeight: CGFloat = 0.0
        if #available(iOS 13.0, *) {
            let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
            statusBarHeight = window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        } else {
            statusBarHeight = UIApplication.shared.statusBarFrame.height
        }
        return statusBarHeight + (self.navigationController?.navigationBar.frame.height ?? 0.0)
    }
    
    var navbarHeight: CGFloat {
        return self.navigationController?.navigationBar.frame.height ?? 0.0
    }
    
    var statusbarHeight: CGFloat {
        var statusBarHeight: CGFloat = 0.0
        if #available(iOS 13.0, *) {
            let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
            statusBarHeight = window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        } else {
            statusBarHeight = UIApplication.shared.statusBarFrame.height
        }
        return statusBarHeight
    }
    
    // set navigationbar color using this public property
    var navigationBarColor: UIColor? = nil {
        didSet {
            if let safeColor = navigationBarColor {
                self.setNavigationBarColor(color: safeColor)
            }
        }
    }
    
    // set navigationBar title using this public property
    var navigationBarTitle: String? = nil {
        didSet {
            if let safeTitle = navigationBarTitle {
                self.setTitle(title: safeTitle)
            }
        }
    }
    
    // set navigationBar title color using this public property
    var navigationBarTitleColor: UIColor = UIColor.black
    
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBarColor = AppColors.themeColor
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }
    
    deinit {
        debugPrint("deinit")
    }
        
    //MARK:- Private methods
    private func setNavigationBarColor(color: UIColor) {
        self.navigationController?.navigationBar.barTintColor = color
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.isTranslucent = false;
    }
    
    private func setTitle(title: String) {
        titleLabel.textAlignment = .center
        let titleAttributes = [NSAttributedString.Key.font: AppFonts.SF_Pro_Bold.withSize(18.0) as Any,
                               NSAttributedString.Key.foregroundColor: AppColors.whiteColor as Any] as [NSAttributedString.Key : Any]
        let attributedTitle = NSAttributedString(string: title, attributes: titleAttributes)
        titleLabel.attributedText = attributedTitle
        self.navigationItem.titleView = titleLabel
    }
    
    private func getButtonFor(itemType: NavigationBarItemType) -> UIButton? {
        let scaleFactor: Double = 1.0
        var osTenYOffSet: Double = 0.0
        if #available(iOS 11.0, *) {
            osTenYOffSet = 0.0
        } else {
            osTenYOffSet = 10.0
        }
        switch itemType {
        case .back:
            self.backButton = UIButton(type: .system)
            self.backButton?.tintColor = UIColor(named: "#282828")
            self.backButton?.frame = CGRect(x: 0.0, y: 7.0 + osTenYOffSet, width: 25.0*scaleFactor, height: 30.0*scaleFactor)
            self.backButton?.setImage(itemType.icon, for: .normal)
            self.backButton?.contentHorizontalAlignment = .left
            self.backButton?.imageView?.contentMode = .scaleAspectFit
            return backButton
        case .sideMenu:
            self.sideMenuBtn = UIButton(type: .custom)
            let kSize: CGFloat = 35.0
            let yPosition = (self.navbarHeight - kSize)/2.0
            let yOffset: CGFloat = CGFloat(osTenYOffSet)
            self.sideMenuBtn?.frame = CGRect(x: 0.0, y: yPosition + yOffset, width: kSize, height: kSize)
            self.sideMenuBtn?.setImage(itemType.icon, for: .normal)
            self.sideMenuBtn?.layer.masksToBounds = true
            self.sideMenuBtn?.imageView?.contentMode = .scaleAspectFill
            return sideMenuBtn
        }
    }
    
    // MARK: - Public Methods
    public func removeNavigationBarBottomLine() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.layoutIfNeeded()
    }
    
    public func restoreNavigationBarBottomLine() {
        self.navigationController?.navigationBar.setBackgroundImage(nil, for:.default)
        self.navigationController?.navigationBar.shadowImage = nil
        self.navigationController?.navigationBar.layoutIfNeeded()
    }
    
    // Use following method to get the instance of the Widget for the given NavigationItem
    public func getInstanceFor(navigationItemType: NavigationBarItemType) -> UIView? {
        switch navigationItemType {
        case .back:
            return self.backButton
        case .sideMenu:
            return self.sideMenuBtn
        }
    }
    
    // Use this method to add left navigation widgets. Just pass the array of required item types.
    // Items will be displayed in the order of their index in the array
    public func addLeftNavigationItems(navigationItems: [NavigationBarItemType]) {
        let containerView = UIView()
        var containerWidth: CGFloat = 0.0
        for itemType in navigationItems {
            var childView: UIView? = nil
            childView = self.getButtonFor(itemType: itemType)
            childView?.frame.origin.x = containerWidth
            containerWidth = containerWidth + (childView?.frame.width)! + 10.0
            containerView.addSubview(childView!)
        }
        containerWidth -= 10.0
        containerView.frame = CGRect(x: 0.0, y: 0.0, width: containerWidth, height: 64.0)
        let leftNavigationItem = UIBarButtonItem(customView: containerView)
        self.navigationItem.leftBarButtonItem = leftNavigationItem
    }
    
    // Use this method to add right navigation widgets. Just pass the array of required item types.
    // Items will be displayed in the order of their index in the array
    public func addRightNavigationItems(navigationItems: [NavigationBarItemType]) {
        let containerView = UIView()
        var containerWidth: CGFloat = 0.0
        for itemType in navigationItems {
            var childView: UIView? = nil
            childView = self.getButtonFor(itemType: itemType)
            childView?.frame.origin.x = containerWidth
            containerWidth = containerWidth + (childView?.frame.width)! + 10.0
            containerView.isHidden = false
            containerView.addSubview(childView!)
        }
        containerWidth -= 10.0
        containerView.frame = CGRect(x: 0.0, y: 15.0, width: containerWidth, height: 60.0)
        let rightNavigationItem = UIBarButtonItem(customView: containerView)
        self.navigationItem.rightBarButtonItem = rightNavigationItem
    }

    // Use this method to add action to navigation bar widgets
    public func addActionFor(navigationItem: NavigationBarItemType, selector: Selector) {
        switch navigationItem {
        case .back:
            if let safeBackBtn = self.backButton {
                safeBackBtn.addTarget(self, action: selector, for: .touchUpInside)
            }
        case .sideMenu:
            if let safeSideBtn = self.sideMenuBtn {
                safeSideBtn.addTarget(self, action: selector, for: .touchUpInside)
            }
        }
    }
}
