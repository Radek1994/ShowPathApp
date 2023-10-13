//
//  CommonSegmentedControl.swift
//  Common
//
//  Created by Radoslaw Slesarczyk on 12/10/2023.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

public class CommonSegmentedControl: UISegmentedControl {
    fileprivate var lastIndex: Int = 0
    
    public override var selectedSegmentIndex: Int {
        didSet {
            lastIndex = selectedSegmentIndex
        }
    }
}

public struct CommonSegmentedControlIndexChange {
    public let before: Int
    public let after: Int
}

extension Reactive where Base: CommonSegmentedControl {

    public var indexChangeObservable: Observable<CommonSegmentedControlIndexChange> {
        return value
            .skip(1)
            .do(afterNext: { [weak base] index in
                base?.lastIndex = index
            }).map { [unowned base] index in
                CommonSegmentedControlIndexChange(before: base.lastIndex, after: index)
            }
    }
}
