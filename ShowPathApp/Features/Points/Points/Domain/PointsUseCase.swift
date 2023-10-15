//
//  PointsUseCase.swift
//  Points
//
//  Created by Radoslaw Slesarczyk on 11/10/2023.
//

import Foundation
import RxSwift
import Common

public class PointsUseCase {
    let repository: PointsRemoteRepositoryContract
    
    public init() {
        self.repository = ApplicationDependency.shared.resolve(PointsRemoteRepositoryContract.self)!
    }
    
    public func getPoints() -> Single<[PointModel]> {
        return repository.getPoints()
            .map { $0.sorted { p1, p2 in
                p1.timestamp < p2.timestamp
            }}
    }
    
    public func getValidatedPoints() -> Single<ValidatedPoints> {
        return repository.getPoints()
            .flatMap { points in
                let validatedPoints = PointsValidator.validatePoints(points)
                return Single.just(validatedPoints)
            }
    }
}
