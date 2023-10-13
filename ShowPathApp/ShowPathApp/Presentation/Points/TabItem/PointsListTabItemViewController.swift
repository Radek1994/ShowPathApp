//
//  PointsListTabItemViewController.swift
//  ShowPathApp
//
//  Created by Radoslaw Slesarczyk on 12/10/2023.
//

import Foundation
import Common
import UIKit
import RxSwift
import RxCocoa
import Points

class PointsListTabItemViewController: CommonViewController<PointsListTabItemViewModel> {
    
    let tableView = UITableView()
    
    override func setupUI() {
        super.setupUI()
        
        view.addSubview(tableView)
        
        PointsListTabItemTableViewCell.registerIn(tableView)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    override func setupRx() {
        super.setupRx()
        
        viewModel.pointsObservable
            .bind(to: tableView.rx.items(commonCellType: PointsListTabItemTableViewCell.self))
            { _, model, cell in
               cell.setupWithModel(model)
            }.disposed(by: disposeBag)
        
        tableView.rx
            .modelSelected(PointModel.self)
            .subscribe { [unowned self] point in
                self.itemSelected(point)
            }.disposed(by: disposeBag)
    }
    
    private func itemSelected(_ point: PointModel) {
        print(point)
    }
}
