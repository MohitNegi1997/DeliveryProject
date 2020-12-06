//
//  AdminFilterCell.swift
//  DemoProject
//
//  Created by Mohit on 06/12/20.
//  Copyright © 2020 Mohit. All rights reserved.
//

import UIKit

class AdminFilterHeaderView: UITableViewHeaderFooterView {
        
    //MARK:- Properties
    private let filterDataSource: [FilterType] = [.date, .deliveryBoyNames,.status]
    private var selectedFilterType: FilterType = .none
    public var onFilterTapped: ((FilterType)->Void)?
    
    //MARK:- IBOutlets
    @IBOutlet weak var filterCollectionView: UICollectionView!
    
    //MARK:- Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    //MARK:- Private Methods
    private func setupView() {
        self.setupCollectionView()
        self.setupColors()
    }
    
    private func setupCollectionView() {
        self.registerCell()
        self.filterCollectionView.delegate = self
        self.filterCollectionView.dataSource = self
    }
    
    private func setupColors() {
        self.filterCollectionView.backgroundColor = AppColors.blackColor
    }
    
    private func registerCell() {
        self.filterCollectionView.registerCell(with: FilterCollectionCell.self)
    }
    
    //MARK:- Public Methods
    public func configureView(with selectedFilter: FilterType) {
        self.selectedFilterType = selectedFilter
        self.filterCollectionView.reloadData()
    }
}

extension AdminFilterHeaderView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.filterDataSource.endIndex
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(with: FilterCollectionCell.self, indexPath: indexPath)
        cell.configureCell(with: self.filterDataSource[indexPath.row].text, isFilterSelected: self.selectedFilterType == self.filterDataSource[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let text = self.filterDataSource[indexPath.row].text
        let width = UILabel.textWidth(font: AppFonts.SF_Pro_Medium.withSize(15.0), text: text)
        return CGSize(width: (width + 80) , height: 45.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedFilter = self.filterDataSource[indexPath.row]
        if selectedFilter == self.selectedFilterType {
            self.onFilterTapped?(.none)
        } else {
            self.onFilterTapped?(selectedFilter)
        }
    }
}
