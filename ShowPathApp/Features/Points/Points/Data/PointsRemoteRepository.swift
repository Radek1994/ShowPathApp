//
//  PointsRemoteRepository.swift
//  Points
//
//  Created by Radoslaw Slesarczyk on 16/10/2023.
//

import Foundation
import Common
import RxSwift

public class PointsRemoteRepository: RemoteRepository, PointsRemoteRepositoryContract {
    
    public func getPoints() -> Single<[PointModel]> {
        return requestData(ofType: [PointModel].self, path: "/points")
    }
}
