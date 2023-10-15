//
//  PointsListTabItemViewModel.swift
//  ShowPathApp
//
//  Created by Radoslaw Slesarczyk on 12/10/2023.
//

import Foundation
import Common
import RxSwift

class PointsListTabItemViewModel: CommonViewModel {
    
    private let item: PointsListTabItem
    private let useCase = PointsUseCase()
    
    let pointsObservable = PublishSubject<[PointModel]>()
    
    init(item: PointsListTabItem) {
        self.item = item
        
        super.init()
    }
    
    override func getData() {
        disposeBag = DisposeBag()
        
        useCase.getValidatedPoints()
            .subscribe { [weak self] validatedPoints in
                self?.handlePoints(validatedPoints)
            } onFailure: { [weak self] error in
                self?.setError(error)
            }.disposed(by: disposeBag)
    }
    
    private func handlePoints(_ validatedPoints: ValidatedPoints) {
        if item == .real {
            pointsObservable.onNext(validatedPoints.realPoints)
        } else {
            pointsObservable.onNext(validatedPoints.fakePoints)
        }
    }
}
