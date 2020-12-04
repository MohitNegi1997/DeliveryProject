//
//  ViewController.swift
//  DemoProject
//
//  Created by Mohit on 29/11/20.
//  Copyright © 2020 Mohit. All rights reserved.
//

import UIKit

class ViewController: BaseVC {

    //MARK:- Properties
    private var isSecurePassword: Bool = true
    private var toolBar: UIToolbar? = nil
    private var pickerView: UIPickerView? = nil
    private let userTypeDataSource: [UserType]  = [.admin, .vendor, .deliveryBoy]
    private let controller: LoginController = LoginController()
    
    //MARK:- IBOutlets
    @IBOutlet weak var bgImgView: UIImageView!
    @IBOutlet weak var bgScrollView: UIScrollView!
    @IBOutlet weak var scrollChildView: UIView!
    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var lblLoginTitle: UILabel!
    @IBOutlet weak var containerStackView: UIStackView!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var lblSelectUserType: UILabel!
    @IBOutlet weak var dropDownImgView: UIImageView!
    @IBOutlet weak var btnSignIn: UIButton!
    
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.loginView.layer.cornerRadius = 4.0
        self.btnSignIn.layer.cornerRadius = 4.0
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        CommonFunctions.disableIQKeyboard()
    }
    
    deinit {
        print_debug("Login ViewController Deinit")
    }
    
    //MARK:- Private Methods
    private func initialSetup() {
        self.setupFonts()
        self.setupImages()
        self.localizedView()
        self.setupTextField()
        self.controller.delegate = self
        CommonFunctions.enableIQKeybaord()
    }

    private func setupFonts() {
        self.lblLoginTitle.font = AppFonts.SF_Pro_Bold.withSize(22.0)
        self.lblSelectUserType.font = AppFonts.SF_Pro_Regular.withSize(14.0)
        self.userNameTextField.font = AppFonts.SF_Pro_Regular.withSize(16.0)
        self.passwordTextField.font = AppFonts.SF_Pro_Regular.withSize(16.0)
        self.btnSignIn.titleLabel?.font = AppFonts.SF_Pro_Bold.withSize(20.0)
    }
    
    private func setupImages() {
        self.dropDownImgView.image = AppImage.dropDown
    }

    private func setupTextField() {
        self.userNameTextField.delegate = self
        self.passwordTextField.delegate = self
        self.userNameTextField.setPlaceholder(with: StringConstants.enter_User_Name.localized, color: AppColors.txtPlaceholderColor)
        self.passwordTextField.setPlaceholder(with: StringConstants.enter_Password.localized, color: AppColors.txtPlaceholderColor)
        self.setupPasswordRightView(isSecureText: self.isSecurePassword)
    }

    private func localizedView() {
        self.lblLoginTitle.text = StringConstants.login_Title.localized
        self.lblSelectUserType.text = StringConstants.select_User_Type.localized
        self.btnSignIn.setTitle(StringConstants.signin_Title.localized.uppercased(), for: .normal)
    }
    
   private func setupPasswordRightView(isSecureText : Bool) {
        self.passwordTextField.isSecureTextEntry = isSecureText
        let button = UIButton()
        button.addTarget(self, action: #selector(self.passwordHideUnhideBtnTapped(_:)), for: .touchUpInside)
        let showIcon = AppImage.showPassword
        let hideIcon = AppImage.hidePasswordImg
        if isSecureText {
            button.setImage(hideIcon, for: .normal)
        } else {
            button.setImage(showIcon, for: .normal)
        }
        self.passwordTextField.setButtonToRightView(btn: button)
    }
    
    private func showPickerView() {
        if self.pickerView == nil {
            self.pickerView = UIPickerView.init()
            self.pickerView?.delegate = self
            self.pickerView?.dataSource = self
            self.pickerView?.backgroundColor = AppColors.blackColor
            self.pickerView?.setValue(AppColors.whiteColor, forKey: "textColor")
            self.pickerView?.autoresizingMask = .flexibleWidth
            self.pickerView?.contentMode = .center
            self.pickerView?.frame = CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height + 300, width: UIScreen.main.bounds.size.width, height: 300)
            self.view.addSubview(self.pickerView!)
            //ToolBar
            self.toolBar = UIToolbar.init(frame: CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height + 300, width: UIScreen.main.bounds.size.width, height: 40))
            self.toolBar?.isTranslucent = true
            let doneBtn = UIBarButtonItem(title: StringConstants.done.localized, style: .done, target: self, action: #selector(onDoneButtonTapped))
            let cancelBtn = UIBarButtonItem(title: StringConstants.cancel.localized, style: .plain, target: self, action: #selector(onCancelBtnTapped))
            doneBtn.tintColor = AppColors.whiteColor
            cancelBtn.tintColor = AppColors.whiteColor
            let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            self.toolBar?.items = [cancelBtn, flexibleSpace, doneBtn]
            self.toolBar?.barTintColor = AppColors.themeColor
            self.view.addSubview(toolBar!)
            self.showPickerViewWithAnimation()
        }
    }
    
    private func showPickerViewWithAnimation() {
        if self.pickerView != nil {
            UIView.animate(withDuration: 0.5) {
                self.pickerView?.frame.origin.y = UIScreen.main.bounds.size.height - 300
                self.toolBar?.frame.origin.y = UIScreen.main.bounds.size.height - 300
            }
        }
    }
    
    private func hidePickerViewWithAnimation() {
        if self.pickerView != nil {
            UIView.animate(withDuration: 0.5, animations: {
                self.pickerView?.frame.origin.y = UIScreen.main.bounds.size.height + 200
                self.toolBar?.frame.origin.y = UIScreen.main.bounds.size.height + 200
            }) { (complete) in
                self.toolBar?.removeFromSuperview()
                self.pickerView?.removeFromSuperview()
                self.pickerView = nil
                self.toolBar = nil
            }
        }
    }
    
    private func updateUserType() {
        if let userType = userType {
            self.lblSelectUserType.text = userType.text
        }
    }
    
    private func requestForLogin() {
        let userName = self.userNameTextField.value
        let password = self.passwordTextField.value
        self.controller.requestForLogin(userName: userName, password: password, userType: userType)
    }
    
    //MARK:- Selector
    @objc func passwordHideUnhideBtnTapped(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        self.isSecurePassword.toggle()
        self.setupPasswordRightView(isSecureText : self.isSecurePassword)
    }
    
    @objc func onDoneButtonTapped() {
        self.hidePickerViewWithAnimation()
        if userType == nil {
            userType = self.userTypeDataSource[0]
        }
        self.updateUserType()
    }
    
    @objc func onCancelBtnTapped() {
        self.hidePickerViewWithAnimation()
        userType = nil
    }
    
    //MARK:- IBActions
    @IBAction func selectUserTypeBtnTapped(_ sender: UIButton) {
        self.view.endEditing(true)
        self.showPickerView()
    }
    
    @IBAction func signInBtnTapped(_ sender: UIButton) {
        self.requestForLogin()
    }
}

//MARK:- TextFieldDelegate
extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.userNameTextField {
            self.passwordTextField.becomeFirstResponder()
        } else if textField == self.passwordTextField {
            self.passwordTextField.resignFirstResponder()
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.hidePickerViewWithAnimation()
    }
}

//MARK:- PickerViewDelegate & DataSource
extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
        
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.userTypeDataSource.endIndex
    }
        
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.userTypeDataSource[row].text
    }
        
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        userType = self.userTypeDataSource[row]
    }
}

//MARK:- LoginDelegate
extension ViewController: LoginControllerDelegate {
    func loginSuccess() {
        if let userType = userType {
            switch userType {
            case .admin: AppRouter.goToAdminHomeVC()
            case .vendor: AppRouter.goToVendorHomeVC()
            case .deliveryBoy: AppRouter.goToLogin()
            }
        } else {
            CommonFunctions.showToastWithMessage("Something wrong")
        }
    }
    
    func loginFailed(message: String) {
        CommonFunctions.showToastWithMessage(message)
    }
}
