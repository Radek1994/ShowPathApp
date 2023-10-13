//
//  Errors.swift
//  Common
//
//  Created by Radoslaw Slesarczyk on 10/09/2023.
//

import Foundation

public enum Errors: LocalizedError {
    case serverError
    case networkError
    case customError(message: String)
    
    public var errorDescription: String? {
        switch self {
        case .serverError:
            return LocalizableStrings.Errors.serverError.localized
        case .networkError:
            return LocalizableStrings.Errors.networkError.localized
        case .customError(let message):
            return message
        }
    }
    
    public func toCommonError() -> CommonError {
        return CommonError(error: self)
    }
}

public class CommonError: LocalizedError {
    private let error: Error
    
    public init(error: Error) {
        self.error = error
    }
    
    public var errorDescription: String? {
        return LocalizableStrings.Common.error.localized
    }
    
    public var message: String {
        if let error = error as? LocalizedError, let errorDescription = error.errorDescription {
            return errorDescription
        } else {
            return error.localizedDescription
        }
    }
}
