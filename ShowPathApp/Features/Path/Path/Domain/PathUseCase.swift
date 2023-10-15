//
//  PathUseCase.swift
//  Path
//
//  Created by Radoslaw Slesarczyk on 15/10/2023.
//

import Foundation
import RxSwift
import Points
import MapKit

public class PathUseCase {
    let pointsUseCase = PointsUseCase()
    
    public init() {
        
    }
    
    public func getPath() -> Single<MKPolyline?> {
        return pointsUseCase.getPoints()
            .flatMap { [weak self] points in
                let path = self?.pointsToPath(points)
                return Single.just(path)
            }
    }
    
    public func getRealPath() -> Single<MKPolyline?> {
        return pointsUseCase.getValidatedPoints()
            .flatMap { [weak self] validatedPoints in
                let path = self?.pointsToPath(validatedPoints.realPoints)
                return Single.just(path)
            }
    }
    
    private func pointsToPath(_ points: [PointModel]) -> MKPolyline {
        let coords = points.map {
            CLLocationCoordinate2D(latitude: $0.latitude, longitude: $0.longitude)
        }
        
        return MKPolyline(coordinates: coords, count: coords.count)
    }
    
    public func getDistance() -> Single<Double> {
        return pointsUseCase.getPoints()
            .flatMap { points in
                let distance = points.map { $0.distance }.max() ?? 0.0
                return Single.just(distance)
            }
    }
    
    public func getRealDistance() -> Single<Double> {
        return pointsUseCase.getValidatedPoints()
            .flatMap { validatedPoints in
                return Single.just(validatedPoints.realDistance)
            }
    }
}
