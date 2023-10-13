//
//  UITableView+extensions.swift
//  Common
//
//  Created by Radoslaw Slesarczyk on 12/10/2023.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

public extension Reactive where Base: UITableView {
    
    func items<Sequence: Swift.Sequence, Cell: CommonTableViewCell<Model>, Source: ObservableType, Model>
        (commonCellType: Cell.Type)
        -> (_ source: Source)
        -> (_ configureCell: @escaping (Int, Sequence.Element, Cell) -> Void)
        -> Disposable
        where Source.Element == Sequence {
            return items(cellIdentifier: Cell.cellIdentifier, cellType: Cell.self)
    }
}
