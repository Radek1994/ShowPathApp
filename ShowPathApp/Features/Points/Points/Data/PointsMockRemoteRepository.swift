//
//  PointsMockRemoteRepository.swift
//  Points
//
//  Created by Radoslaw Slesarczyk on 12/10/2023.
//

import Foundation
import Common
import RxSwift

class PointsMockRemoteRepository: MockRemoteRepository, PointsRemoteRepositoryContract {
    
    func getPoints() -> Single<[PointModel]> {
        return readObject(ofType: [PointModel].self, fromFile: "path", withExtension: "json").map { $0 ?? [] }
    }
}
