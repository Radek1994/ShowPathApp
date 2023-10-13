//
//  CommonSeparatorView.swift
//  Common
//
//  Created by Radoslaw Slesarczyk on 12/10/2023.
//

import Foundation
import UIKit
import SnapKit

public class CommonSeparatorView: CommonView {
    
    private let height: Double
    
    public init(height: Double = 1.0) {
        self.height = height
        
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func setupUI() {
        super.setupUI()
    }
    
    override public func setupConstraints() {
        super.setupConstraints()
        
        self.snp.makeConstraints {
            $0.height.equalTo(height)
        }
    }
}
