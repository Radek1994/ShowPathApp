//
//  PointsDetailsViewModel.swift
//  Points
//
//  Created by Radoslaw Slesarczyk on 13/10/2023.
//

import Foundation
import Common
import RxSwift
import MapKit
import Contacts

class PointsDetailsViewModel: CommonViewModel {
    
    func getAddressFromPoint(_ point: PointModel) -> Observable<String> {
        
        return Observable.create { observer in
            CLGeocoder().reverseGeocodeLocation(CLLocation(latitude: point.latitude, longitude: point.longitude)) { placemark, _ in
                guard let placemark = placemark?.first, let postalAddress = placemark.postalAddress else {
                    observer.onCompleted()
                    return
                }
                
                let address = CNPostalAddressFormatter().string(from: postalAddress)
                observer.onNext(address)
                observer.onCompleted()
            }
            
            return Disposables.create()
        }
    }
}
