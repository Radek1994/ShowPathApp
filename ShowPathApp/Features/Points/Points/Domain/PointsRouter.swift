//
//  PointsRouter.swift
//  Points
//
//  Created by Radoslaw Slesarczyk on 13/10/2023.
//

import Foundation
import Common
import UIKit

public struct PointsRouter {
    
    public static func routeToDetails(from viewController: UIViewController, model: PointModel) {
        PointsPaths.details.follow(from: viewController, arg: model)
    }
}
