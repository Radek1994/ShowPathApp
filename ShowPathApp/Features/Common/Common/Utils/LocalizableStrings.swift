//
//  LocalizableStrings.swift
//  Common
//
//  Created by Radoslaw Slesarczyk on 08/09/2023.
//

import Foundation

public extension LocalizableStrings {
    
    enum Common: String, Localizable {
        case loading = "common.loading"
        case all = "common.all"
        case error = "common.error"
        
        public var bundle: Bundle { return Bundle(for: CommonBundleClass.self) }
    }
    
    enum Errors: String, Localizable {
        case serverError = "errors.serverError"
        case networkError = "errors.networkError"
        
        public var bundle: Bundle { return Bundle(for: CommonBundleClass.self) }
    }
}

class CommonBundleClass { }
