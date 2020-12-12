//
//  CompleteTaskDetailVC.swift
//  DemoProject
//
//  Created by Mohit on 10/12/20.
//  Copyright © 2020 Mohit. All rights reserved.
//

import UIKit

class CompleteTaskDetailVC: BaseVC {
    
    //MARK:- Properties
    private let dataSource: [CompleteTaskDetailType] = [.vendorName, .consigneeName, .contactDetail, .pickupLocation, .dimensions, .weight, .handlingInstruction, .deliveryLocation, .deliveryDateTime, .distance, .totalAmt, .photoPickup, .saveBtn]
    private var pickedImg: UIImage? = nil
    
    //MARK:- IBOutlets
    @IBOutlet weak var completeTaskTblView: UITableView!
    
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
        print_debug("CompleteTaskDetailVC Deinit")
    }
    
    //MARK:- Private Methods
    private func initialSetup() {
        self.setupNavigation()
        self.setupTblView()
        CommonFunctions.enableIQKeybaord()
    }
        
    private func setupNavigation() {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationBarTitle = StringConstants.completeTaskDetail.localized
        self.addLeftNavigationItems(navigationItems: [.back])
        self.addActionFor(navigationItem: .back, selector: #selector(self.backBtnTapped))
        self.removeNavigationBarBottomLine()
    }
    
    private func setupTblView() {
        self.registerCell()
        self.completeTaskTblView.delegate = self
        self.completeTaskTblView.dataSource = self
    }
    
    private func registerCell() {
        self.completeTaskTblView.registerCell(with: CompleteTaskDetailCell.self)
        self.completeTaskTblView.registerCell(with: CameraCell.self)
        self.completeTaskTblView.registerCell(with: SubmitButtonCell.self)
    }
    
    private func openSheetForCamera() {
        AttachmentHandler.shared.showAttachmentActionSheet(vc: self, title: "Choose Option", message: "", attachmentTypes: [.camera, .photoLibrary])
        AttachmentHandler.shared.imagePickedBlock = { [weak self] (image) in
            guard let self = self else { return }
            self.pickedImg = image
            self.completeTaskTblView.reloadData()
        }
    }
    
    //MARK:- Public Methods
    
    //MARK:- Selectors
    @objc func backBtnTapped() {
         self.pop()
     }
    
    //MARK:- IBActions
}

//MARK:- UITableViewDelegate + DataSource
extension CompleteTaskDetailVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.endIndex
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch self.dataSource[indexPath.row] {
        case .photoPickup:
            let cell = tableView.dequeueCell(with: CameraCell.self, indexPath: indexPath)
            cell.configureCell(with: "", pickedImg: self.pickedImg)
            cell.onTappedBtn = { [weak self] in
                guard let self = self else { return }
                self.openSheetForCamera()
            }
            return cell
        case .saveBtn:
            let cell = tableView.dequeueCell(with: SubmitButtonCell.self, indexPath: indexPath)
            cell.configureCellForCompleteTask()
            cell.onTapSubmit = { [weak self] in
                guard let self = self else { return }
                self.pop()
            }
            return cell
        default:
            let cell = tableView.dequeueCell(with: CompleteTaskDetailCell.self, indexPath: indexPath)
            cell.configureCell(with: self.dataSource[indexPath.row].text)
            cell.commonTxtField.isUserInteractionEnabled = self.dataSource[indexPath.row] == .distance || self.dataSource[indexPath.row] == .totalAmt
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
