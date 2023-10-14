//
//  MockRemoteRepository.swift
//  Common
//
//  Created by Radoslaw Slesarczyk on 08/09/2023.
//

import Foundation
import RxSwift

open class MockRemoteRepository: RemoteRepository {
        
    let bundle: Bundle
    
    public override init() {
        self.bundle = Bundle(for: type(of: self))
        
        super.init()
    }
    
    public func readObject<T: Decodable>(ofType type: T.Type, fromFile fileName: String, withExtension: String) -> Single<T?> {
        return Observable.create { observer in
            let delay = Double.random(in: 1.0...2.0)
            let shouldFail = false//Double.random(in: 0.0...1.0) > 0.9
            
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                if shouldFail {
                    observer.onError(Errors.serverError.toCommonError())
                } else {
                    guard let data = self.readContentsOfFile(fileName: fileName, withExtension: withExtension) else {
                        observer.onNext(nil)
                        observer.onCompleted()
                        return
                    }
                    
                    var object: T? = nil
                    
                    do {
                        object = try JSONDecoder().decode(T.self, from: data)
                    } catch let error {
                        Logger.error(error)
                        observer.onError(CommonError(error: error))
                        return
                    }
                    
                    observer.onNext(object)
                    observer.onCompleted()
                }
            }
            
            return Disposables.create()
        }.asSingle()
    }
    
    func readContentsOfFile(fileName: String, withExtension: String) -> Data? {
        guard let url = bundle.url(forResource: fileName, withExtension: withExtension) else {
            Logger.debug("Cannot find url for file \(fileName)")
            return nil
        }
        
        do {
            return try Data(contentsOf: url)
        } catch let error {
            Logger.error(error)
            return nil
        }
    }
}
