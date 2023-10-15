//
//  NavigationBarLogoView.swift
//  ShowPathApp
//
//  Created by Radoslaw Slesarczyk on 15/10/2023.
//

import Foundation
import UIKit
import Common
import SnapKit

class NavigationBarLogoView: CommonView {
    
    let navBarLogoImageView = UIImageView(image: UIImage(named: "Logo"))
    
    override func setupUI() {
        super.setupUI()
        
        addSubview(navBarLogoImageView)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        navBarLogoImageView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(8)
            $0.width.equalTo(navBarLogoImageView.snp.height)
        }
    }
}
