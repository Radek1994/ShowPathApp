//
//  Localizable.swift
//  Common
//
//  Created by Radoslaw Slesarczyk on 11/09/2023.
//

import Foundation

public enum LocalizableStrings {
    
}

public protocol Localizable {
    var bundle: Bundle { get }
}

public extension RawRepresentable where Self: Localizable, RawValue == String {
    var localized: String {
        bundle.localizedString(forKey: self.rawValue, value: nil, table: nil)
    }
}
