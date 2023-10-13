//
//  PointsListTabItem.swift
//  ShowPathApp
//
//  Created by Radoslaw Slesarczyk on 12/10/2023.
//

import Foundation
import UIKit
import Points
import Common

enum PointsListTabItem: CaseIterable {
    case real
    case fake
    
    func viewController() -> UIViewController {
        switch self {
        case .real:
            return PointsListTabItemViewController(viewModel: PointsListTabItemViewModel(item: .real))
        case .fake:
            return PointsListTabItemViewController(viewModel: PointsListTabItemViewModel(item: .fake))
        }
    }
    
    func title() -> String {
        switch self {
        case .real:
            return LocalizableStrings.Points.List.real.localized
        case .fake:
            return LocalizableStrings.Points.List.fake.localized
        }
    }
}
