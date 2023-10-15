//
//  LoadingView.swift
//  Common
//
//  Created by Radoslaw Slesarczyk on 10/09/2023.
//

import Foundation
import UIKit
import SnapKit

public class LoadingView: CommonView {
    
    let backgroundView = UIView()
    let loadingIndicatorContainerView = UIView()
    let loadingIndicatorCenterView = UIView()
    let activityIndicator = UIActivityIndicatorView()
    let label = UILabel()
    
    public override func setupUI() {
        super.setupUI()
        
        addSubview(backgroundView)
        addSubview(loadingIndicatorContainerView)
        loadingIndicatorContainerView.addSubview(loadingIndicatorCenterView)
        loadingIndicatorCenterView.addSubview(activityIndicator)
        loadingIndicatorCenterView.addSubview(label)
        
        backgroundView.alpha = 0.5
        backgroundView.backgroundColor = .lightGray
        
        loadingIndicatorContainerView.backgroundColor = .gray
        loadingIndicatorContainerView.alpha = 0.8
        loadingIndicatorContainerView.setCornerRadius(16)
        
        activityIndicator.startAnimating()
        
        label.text = LocalizableStrings.Common.loading.localized
    }
    
    public override func setupConstraints() {
        super.setupConstraints()
        
        backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        loadingIndicatorContainerView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(loadingIndicatorContainerView.snp.height)
        }
        
        loadingIndicatorCenterView.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
        
        activityIndicator.snp.makeConstraints {
            $0.top.equalToSuperview().offset(32)
            $0.centerX.equalToSuperview()
        }
        
        label.snp.makeConstraints {
            $0.top.equalTo(activityIndicator.snp.bottom).offset(16)
            $0.left.right.bottom.equalToSuperview().inset(16)
        }
    }
}
