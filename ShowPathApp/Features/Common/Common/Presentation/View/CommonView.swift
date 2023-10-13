//
//  CommonView.swift
//  Common
//
//  Created by Radoslaw Slesarczyk on 12/10/2023.
//

import Foundation
import UIKit

open class CommonView: UIView {
    
    public init() {
        super.init(frame: .zero)
        
        setupUI()
        setupConstraints()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func setupUI() {
        
    }
    
    open func setupConstraints() {
        
    }
}
