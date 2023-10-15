//
//  LocalizableStrings.swift
//  Points
//
//  Created by Radoslaw Slesarczyk on 12/10/2023.
//

import Foundation
import Common

public extension LocalizableStrings {
    
    enum Points: String, Localizable {
        case title = "points.title"
        
        public enum List: String, Localizable {
            case real = "points.list.real"
            case fake = "points.list.fake"
            
            public var bundle: Bundle { return Bundle(for: PointsBundleClass.self) }
        }
        
        public enum Details: String, Localizable {
            case timestamp = "points.details.timestamp"
            case accuracy = "points.details.accuracy"
            
            public var bundle: Bundle { return Bundle(for: PointsBundleClass.self) }
        }
        
        public var bundle: Bundle { return Bundle(for: PointsBundleClass.self) }
    }
}

class PointsBundleClass { }
