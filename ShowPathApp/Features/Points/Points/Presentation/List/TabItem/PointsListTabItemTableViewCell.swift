//
//  PointsListTabItemTableViewCell.swift
//  ShowPathApp
//
//  Created by Radoslaw Slesarczyk on 12/10/2023.
//

import UIKit
import Common

class PointsListTabItemTableViewCell: CommonTableViewCell<PointModel> {
    
    let titleLabel = UILabel()
    
    override func setupUI() {
        contentView.addSubview(titleLabel)
    }
    
    override func setupConstraints() {
        
        titleLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(8)
            $0.left.right.equalToSuperview().inset(16)
        }
    }
    
    override func setupWithModel(_ model: PointModel) {
        titleLabel.text = "\(model.longitude) \(model.latitude)"
    }
}

