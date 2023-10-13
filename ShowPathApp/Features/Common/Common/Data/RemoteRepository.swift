//
//  RemoteRepository.swift
//  Common
//
//  Created by Radoslaw Slesarczyk on 08/09/2023.
//

import Foundation
import RxSwift

open class RemoteRepository {
    let networkAccessManager = NetworkAccessManager()
    
    public init() { }
    
    public func requestData<T: Decodable>(ofType type: T.Type, path: String, method: HTTPMethod = .GET) -> Single<T> {
        return networkAccessManager.requestData(ofType: type, path: path, method: method)
    }
}

public enum HTTPMethod: String {
    case GET = "GET"
    case POST = "POST"
    case PATCH = "PATCH"
}
