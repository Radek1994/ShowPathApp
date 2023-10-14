//
//  UIView+extensions.swift
//  Common
//
//  Created by Radoslaw Slesarczyk on 14/10/2023.
//

import Foundation
import UIKit

public extension UIView {
    
    func setCornerRadius(_ radius: CGFloat) {
        layer.cornerRadius = radius
        layer.masksToBounds = true
    }
}
