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
    
    var dataType: MapViewModelDataType = .fake
        
    override func getData() {
        disposeBag = DisposeBag()
        
        if dataType == .real {
            useCase.getRealPath()
                .subscribe { [weak self] path in
                    if let path = path {
                        self?.pathObservable.onNext(path)
                    }
                } onFailure: { [weak self] error in
                    self?.setError(error)
                }.disposed(by: disposeBag)
        } else {
            useCase.getPath()
                .subscribe { [weak self] path in
                    if let path = path {
                        self?.pathObservable.onNext(path)
                    }
                } onFailure: { [weak self] error in
                    self?.setError(error)
                }.disposed(by: disposeBag)
        }
    }
}

enum MapViewModelDataType {
    case real
    case fake
}
