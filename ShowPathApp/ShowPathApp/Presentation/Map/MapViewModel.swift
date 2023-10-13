//
//  MapViewModel.swift
//  ShowPathApp
//
//  Created by Radoslaw Slesarczyk on 09/10/2023.
//

import Foundation
import RxSwift
import RxCocoa
import MapKit
import Points
import Common

class MapViewModel: CommonViewModel {
    
    private let useCase = PointsUseCase()
    
    let pathObservable = PublishSubject<MKPolyline>()
        
    override func getData() {
        disposeBag = DisposeBag()
        
        useCase.getPoints()
            .subscribe { [weak self] points in
                self?.handlePoints(points)
            } onFailure: { [weak self] error in
                self?.setError(error)
            }.disposed(by: disposeBag)
    }
    
    private func handlePoints(_ points: [PointModel]) {
        let distances = zip(points, points.dropFirst())
            .map { $0.1.distance - $0.0.distance }
        let avg = distances.avg()
        let std = distances.std()

        var lastPoint = points.first!
        var falsePoints = [PointModel]()
        var falseDistance = 0.0

        let points = points.filter {
            let dist = $0.distance - lastPoint.distance
            if dist > avg + std || dist == 0.0 {
                falsePoints.append($0)
                falseDistance += dist
                lastPoint = $0
                return false
            } else {
                lastPoint = $0
                return true
            }
        }
        
//        let distances = points.map { $0.accuracy }
//        let avg = distances.avg()
//        let std = distances.std()
//
//        var lastPoint = points.first!
//        var falsePoints = [PointModel]()
//
//        points = points.filter {
//            let dist = $0.accuracy
//            if dist < avg - std {
//                //print(dist)
//                falsePoints.append($0)
//                lastPoint = $0
//                return false
//            } else {
//                lastPoint = $0
//                return true
//            }
//        }
        
        print(falsePoints.count)
        print(points.count)
        print(points.last!.distance, falseDistance, points.last!.distance - falseDistance)
        
//        let annotations = points.map {
//            var annotation = MKPointAnnotation()
//            annotation.coordinate = CLLocationCoordinate2D(latitude: Double($0.latitude) ?? 0.0, longitude: Double($0.longitude) ?? 0.0)
//            return annotation
//        }
        
        let coords = points.map {
            CLLocationCoordinate2D(latitude: $0.latitude, longitude: $0.longitude)
        }
        
        let polyline = MKPolyline(coordinates: coords, count: coords.count)
        
        pathObservable.onNext(polyline)
    }
}
