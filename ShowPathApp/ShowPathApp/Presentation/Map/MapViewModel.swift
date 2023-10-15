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
import Common
import Path

class MapViewModel: CommonViewModel {
    
    private let useCase = PathUseCase()
    
    let pathObservable = PublishSubject<MKPolyline>()
    let distanceTextObservable = PublishSubject<String>()
    
    var dataType: MapViewModelDataType = .all
        
    override func getData() {
        disposeBag = DisposeBag()
        
        let pathObservable: Single<MKPolyline?>
        let distanceObservable: Single<Double>
        
        if dataType == .real {
            pathObservable = useCase.getRealPath()
            distanceObservable = useCase.getRealDistance()
        } else {
            pathObservable = useCase.getPath()
            distanceObservable = useCase.getDistance()
        }
        
        pathObservable
            .subscribe { [weak self] path in
                if let path = path {
                    self?.pathObservable.onNext(path)
                }
            } onFailure: { [weak self] error in
                self?.setError(error)
            }.disposed(by: disposeBag)
        
        distanceObservable
            .subscribe { [weak self] distance in
                self?.handleDistance(distance)
            } onFailure: { [weak self] error in
                self?.setError(error)
            }.disposed(by: disposeBag)
    }
    
    private func handleDistance(_ distance: Double) {
        let distanceTitle: String
        if dataType == .real {
            distanceTitle = LocalizableStrings.ShowPathApp.realDistance.localized
        } else {
            distanceTitle = LocalizableStrings.ShowPathApp.distance.localized
        }
        
        let text = String(format: "%@: %.2fkm", distanceTitle, distance)
        distanceTextObservable.onNext(text)
    }
    
    public func switchDataType() {
        if dataType == .real {
            dataType = .all
        } else {
            dataType = .real
        }
        
        getData()
    }
}

enum MapViewModelDataType {
    case real
    case all
}
