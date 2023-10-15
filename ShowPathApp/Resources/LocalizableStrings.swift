//
//  LocalizableStrings.swift
//  ShowPathApp
//
//  Created by Radoslaw Slesarczyk on 15/10/2023.
//

import Foundation
import Common

public extension LocalizableStrings {
    
    enum ShowPathApp: String, Localizable {
        case distance = "ShowPathApp.distance"
        case realDistance = "ShowPathApp.realDistance"
        
        public var bundle: Bundle { return Bundle(for: ShowPathAppBundleClass.self) }
    }
}

class ShowPathAppBundleClass { }

