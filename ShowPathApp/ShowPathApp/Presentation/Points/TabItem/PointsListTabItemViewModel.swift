//
//  PointsListTabItemViewModel.swift
//  ShowPathApp
//
//  Created by Radoslaw Slesarczyk on 12/10/2023.
//

import Foundation
import Common
import Points
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
        
        useCase.getPoints()
            .subscribe { [weak self] points in
                self?.handlePoints(points)
            } onFailure: { [weak self] error in
                self?.setError(error)
            }.disposed(by: disposeBag)
    }
    
    private func handlePoints(_ points: [PointModel]) {
        pointsObservable.onNext(points)
    }
}
