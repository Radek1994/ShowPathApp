//
//  PointsPaths.swift
//  Points
//
//  Created by Radoslaw Slesarczyk on 13/10/2023.
//

import Foundation
import Common

struct PointsPaths {
    
    static var details = ModalPath<PointModel> { model in
        PointsDetailsViewController(viewModel: PointsDetailsViewModel(), model: model)
    }
}
