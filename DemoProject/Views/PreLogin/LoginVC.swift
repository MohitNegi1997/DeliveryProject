//
//  ViewController.swift
//  DemoProject
//
//  Created by Mohit on 29/11/20.
//  Copyright © 2020 Mohit. All rights reserved.
//

import UIKit

class LoginVC: BaseVC {

    //MARK:- Properties
    private var isSecurePassword: Bool = true
    private let userTypeDataSource: [UserType]  = [.admin, .vendor, .deliveryBoy]
    private var selectedRole: UserType? = nil
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
        let pickerVC = PickerVC.instantiate(fromAppStoryboard: .picker)
        pickerVC.pickerDataSource = self.userTypeDataSource
        pickerVC.onTapDone = { [weak self] (pickedType) in
            guard let self = self else { return }
            guard let roleType = pickedType as? UserType else { return }
            self.selectedRole = roleType
            self.updateUserType()
        }
        pickerVC.onTapCancel = { [weak self] in
            guard let _ = self else { return }
            print_debug("Tap on cancel button")
        }
        pickerVC.modalPresentationStyle = .overCurrentContext
        self.present(pickerVC, animated: false, completion: nil)
    }
    
    private func updateUserType() {
        if let userType = self.selectedRole {
            self.lblSelectUserType.text = userType.text
        }
    }
    
    private func requestForLogin() {
        let userName = self.userNameTextField.value
        let password = self.passwordTextField.value
        self.controller.requestForLogin(userName: userName, password: password, userType: self.selectedRole)
    }
    
    //MARK:- Selector
    @objc func passwordHideUnhideBtnTapped(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        self.isSecurePassword.toggle()
        self.setupPasswordRightView(isSecureText : self.isSecurePassword)
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
extension LoginVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.userNameTextField {
            self.passwordTextField.becomeFirstResponder()
        } else if textField == self.passwordTextField {
            self.passwordTextField.resignFirstResponder()
        }
        return true
    }
}

//MARK:- LoginDelegate
extension LoginVC: LoginControllerDelegate {
    func loginSuccess() {
        userType = self.selectedRole
        if let userType = self.selectedRole {
            switch userType {
            case .admin: AppRouter.goToAdminHomeVC()
            case .vendor: AppRouter.goToVendorHomeVC()
            case .deliveryBoy: AppRouter.goToDeliveryBoyHomeVC()
            }
        } else {
            CommonFunctions.showToastWithMessage("Something wrong")
        }
    }
    
    func loginFailed(message: String) {
        CommonFunctions.showToastWithMessage(message)
    }
}
