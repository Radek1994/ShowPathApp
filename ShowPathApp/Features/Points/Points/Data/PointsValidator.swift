//
//  PointsValidator.swift
//  Points
//
//  Created by Radoslaw Slesarczyk on 15/10/2023.
//

import Foundation
import RxSwift
import Common

public struct PointsValidator {
    
    public static func validatePoints(_ points: [PointModel]) -> ValidatedPoints {
        var realPoints = [PointModel]()
        var fakePoints = [PointModel]()
        var realDistance = 0.0
        var fakeDistance = 0.0
        
        guard let firstPoint = points.first else {
            return ValidatedPoints(realPoints: realPoints, fakePoints: fakePoints, realDistance: realDistance)
        }
        
        let distances = zip(points, points.dropFirst())
            .map { $0.1.distance - $0.0.distance }
        let avg = distances.avg()
        let std = distances.std()
        
        realPoints = [firstPoint]
        
        zip(points.dropFirst(), distances)
            .forEach { (point, dist) in
                if dist > avg + std || dist == 0.0 {
                    fakePoints.append(point)
                    fakeDistance += dist
                } else {
                    realPoints.append(point)
                }
            }
        
        if let distance = points.map({ $0.distance }).max() {
            realDistance = distance - fakeDistance
        }
        
        return ValidatedPoints(realPoints: realPoints, fakePoints: fakePoints, realDistance: realDistance)
    }
}

public struct ValidatedPoints {
    public let realPoints: [PointModel]
    public let fakePoints: [PointModel]
    public let realDistance: Double
}
