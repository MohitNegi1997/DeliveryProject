//
//  UserCreationVC.swift
//  DemoProject
//
//  Created by Mohit on 05/12/20.
//  Copyright © 2020 Mohit. All rights reserved.
//

import UIKit

class UserCreationVC: BaseVC {
    
    //MARK:- Properties
    private let userCreationDataSource: [UserCreationType] = UserCreationType.getDataSource()
    private let chooseRoleDataSource: [UserType] = [.vendor,.deliveryBoy]
    
    //MARK:- IBOutlets
    @IBOutlet weak var userCreationTblView: UITableView!
    
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialSetup()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        CommonFunctions.disableIQKeyboard()
    }
    
    deinit {
        print_debug("UserCreation Deinit")
    }
    
    //MARK:- Private Methods
    private func initialSetup() {
        self.setupNavigation()
        self.setupTblView()
        CommonFunctions.enableIQKeybaord()
    }
        
    private func setupNavigation() {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationBarTitle = StringConstants.userCreation.localized
        self.addLeftNavigationItems(navigationItems: [.back])
        self.addActionFor(navigationItem: .back, selector: #selector(self.backBtnTapped))
        self.removeNavigationBarBottomLine()
    }
    
    private func setupTblView() {
        self.registerCell()
        self.userCreationTblView.delegate = self
        self.userCreationTblView.dataSource = self
    }
    
    private func registerCell() {
        self.userCreationTblView.registerCell(with: CommonTFCell.self)
        self.userCreationTblView.registerCell(with: AddressCell.self)
        self.userCreationTblView.registerCell(with: SubmitButtonCell.self)
    }
    
    private func openPickerView() {
        let pickerVC = PickerVC.instantiate(fromAppStoryboard: .picker)
        pickerVC.pickerType = .loginPicker
        pickerVC.pickerDataSource = self.chooseRoleDataSource
        pickerVC.onTapDone = { [weak self] (pickedType) in
            guard let _ = self else { return }
            ///To do later
            guard let roleType = pickedType as? UserType else { return }
            print_debug(roleType.text)
        }
        pickerVC.onTapCancel = { [weak self] in
            guard let _ = self else { return }
            print_debug("Tap on Cancel")
        }
        pickerVC.modalPresentationStyle = .overCurrentContext
        self.present(pickerVC, animated: false, completion: nil)
    }
    
    //MARK:- Public Methods
    
    //MARK:- Selectors
    @objc func backBtnTapped() {
         self.pop()
     }
    
    //MARK:- IBActions
}

//MARK:- UITableViewDelegate + DataSource
extension UserCreationVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.userCreationDataSource.endIndex
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch self.userCreationDataSource[indexPath.row] {
        case .firstName(let tfType), .lastName(let tfType),
             .chooseRole(let tfType), .phoneNo(let tfType),
             .userName(let tfType), .password(let tfType):
            let cell = tableView.dequeueCell(with: CommonTFCell.self, indexPath: indexPath)
            cell.configureCellForUserCreation(with: tfType)
            cell.onTapBtn = { [weak self] in
                guard let self = self else { return }
                self.openPickerView()
            }
            return cell
        case .address:
            let cell = tableView.dequeueCell(with: AddressCell.self, indexPath: indexPath)
            cell.configureCellForUserCreation(with: StringConstants.address.localized)
            return cell
        case .button:
            let cell = tableView.dequeueCell(with: SubmitButtonCell.self, indexPath: indexPath)
            cell.configureCellForUserCreation()
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.tableView(tableView, heightForRowAt: indexPath)
    }
}
