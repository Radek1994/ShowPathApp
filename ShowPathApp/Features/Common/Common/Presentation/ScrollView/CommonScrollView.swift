//
//  CommonScrollView.swift
//  Common
//
//  Created by Radoslaw Slesarczyk on 14/10/2023.
//

import Foundation
import UIKit
import SnapKit

public class CommonScrollView: UIView {
    
    private let scrollView = UIScrollView()
    private let wrapper = UIView()
    public let contentView = UIView()
    
    public init() {
        super.init(frame: .zero)
        
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(scrollView)
        scrollView.addSubview(wrapper)
        wrapper.addSubview(contentView)
    }
    
    private func setupConstraints() {
        
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        wrapper.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(self)
        }

        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
