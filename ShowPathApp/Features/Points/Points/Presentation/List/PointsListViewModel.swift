//
//  PointsListViewModel.swift
//  ShowPathApp
//
//  Created by Radoslaw Slesarczyk on 11/10/2023.
//

import Foundation
import Common

public class PointsListViewModel: CommonViewModel {
    
    let viewControllers = PointsListTabItem.allCases.map { $0.viewController() }
    let segmentedControlItems = PointsListTabItem.allCases.map { $0.title() }
}
