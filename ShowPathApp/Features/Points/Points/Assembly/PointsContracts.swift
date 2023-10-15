//
//  PointsContracts.swift
//  Points
//
//  Created by Radoslaw Slesarczyk on 12/10/2023.
//

import Foundation
import RxSwift

public protocol PointsRemoteRepositoryContract {
    func getPoints() -> Single<[PointModel]>
}
