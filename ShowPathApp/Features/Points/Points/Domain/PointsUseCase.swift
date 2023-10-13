//
//  PointsUseCase.swift
//  Points
//
//  Created by Radoslaw Slesarczyk on 11/10/2023.
//

import Foundation
import RxSwift

public struct PointsUseCase {
    let repository: PointsRemoteRepositoryContract = PointsMockRemoteRepository()
    
    public init() {
        
    }
//    init(repository: PointsRemoteRepositoryContract) {
//        self.repository = repository
//    }
    
    public func getPoints() -> Single<[PointModel]> {
        return repository.getPoints()
    }
}
