//
//  Array+extensions.swift
//  Common
//
//  Created by Radoslaw Slesarczyk on 12/10/2023.
//

import Foundation

public extension Array {
    
    func haveIndex(_ index: Int) -> Bool {
        return (0..<self.count).contains(index)
    }
}

public extension Array where Element: FloatingPoint {

    func sum() -> Element {
        return self.reduce(0, +)
    }

    func avg() -> Element {
        return self.sum() / Element(self.count)
    }

    func std() -> Element {
        let mean = self.avg()
        let v = self.reduce(0, { $0 + ($1-mean)*($1-mean) })
        return sqrt(v / (Element(self.count) - 1))
    }
}
