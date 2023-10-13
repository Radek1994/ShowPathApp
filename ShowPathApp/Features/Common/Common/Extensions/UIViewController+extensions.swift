//
//  UIViewController+extensions.swift
//  Common
//
//  Created by Radoslaw Slesarczyk on 12/10/2023.
//

import Foundation
import UIKit
import SnapKit

public extension UIViewController {
    
    func embedViewController(_ viewController: UIViewController, inView embedingView: UIView) {
        addChild(viewController)
        embedingView.addSubview(viewController.view)
        
        viewController.view.snp.makeConstraints {
            $0.edges.equalTo(embedingView)
        }
        
        viewController.willMove(toParent: self)
    }
}
