//
//  CommonViewModel.swift
//  Common
//
//  Created by Radoslaw Slesarczyk on 12/10/2023.
//

import Foundation
import RxSwift
import RxRelay

open class CommonViewModel {
    public let error = PublishSubject<CommonError>()
    public let isLoading = BehaviorSubject(value: false)
    public var disposeBag = DisposeBag()
    
    public init() { }
    
    public func setError(_ error: Error) {
        self.error.onNext(CommonError(error: error))
    }
    
    open func getData() { }
}
