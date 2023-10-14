//
//  PointsDetailsViewController.swift
//  Points
//
//  Created by Radoslaw Slesarczyk on 13/10/2023.
//

import Foundation
import Common
import UIKit
import SnapKit

class PointsDetailsViewController: CommonViewController<PointsDetailsViewModel> {
    
    let titleLabel = UILabel()
    
    let model: PointModel
    
    init(viewModel: PointsDetailsViewModel, model: PointModel) {
        self.model = model
        
        super.init(viewModel: viewModel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupUI() {
        super.setupUI()
        
        view.addSubview(titleLabel)
        
        view.backgroundColor = .white
        
        titleLabel.text = "\(model)"
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        titleLabel.snp.makeConstraints {
            $0.top.left.right.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
    }
}
