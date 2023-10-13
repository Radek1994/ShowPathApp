//
//  NetworkAccessManager.swift
//  Common
//
//  Created by Radoslaw Slesarczyk on 10/09/2023.
//

import Foundation
import RxSwift
import RxCocoa
import Network

class NetworkAccessManager {
    private let apiURL: String
    private let networkMonitor = NWPathMonitor()
    private let monitorQueue = DispatchQueue(label: "MonitorQueue")
    private var networkStatus: NetworkStatus = .connected
    
    init() {
        self.apiURL = ConfigReader.shared.getProperty(forKey: "apiURL") ?? ""
        startNetworkMonitor()
    }
    
    private func startNetworkMonitor() {
        networkMonitor.pathUpdateHandler = { [weak self] path in
            switch path.status {
            case .satisfied:
                self?.networkStatus = .connected
            default:
                self?.networkStatus = .notConnected
            }
        }
        networkMonitor.start(queue: monitorQueue)
    }
    
    public func requestData<T: Decodable>(ofType type: T.Type, path: String, method: HTTPMethod) -> Single<T> {
        guard networkStatus == .connected else {
            return Observable.error(Errors.networkError.toCommonError()).asSingle()
        }
        
        let urlString = apiURL + path
        
        guard let url = URL(string: urlString) else {
            return Observable.error(Errors.serverError.toCommonError()).asSingle()
        }
        
        return URLSession.shared
            .rx
            .data(request: URLRequest(url: url))
            .decode(type: T.self, decoder: JSONDecoder())
            .asSingle()
        
//        return URLSession.shared
//            .dataTaskPublisher(for: url)
//            .map(\.data)
//            .decode(type: T.self, decoder: JSONDecoder())
//            .mapError { CommonError(error: $0) }
//            .eraseToAnyPublisher()
    }
}

private enum NetworkStatus {
    case connected
    case notConnected
}
