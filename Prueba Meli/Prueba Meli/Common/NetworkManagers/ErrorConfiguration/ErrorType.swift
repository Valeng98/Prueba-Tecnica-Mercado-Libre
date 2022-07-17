//
//  ErrorType.swift
//  Prueba Meli
//
//  Created by Valentina Guarnizo on 15/07/22.
//

import Foundation

enum ErrorType: Error, LocalizedError {
    case generic(reason: String)
    case `internal`(reason: String)
    
    var errorDescription: String? {
        switch self {
        case .generic(let reason):
            return reason
        case .internal(let reason):
            return "Internal Error: \(reason)"
        }
    }
}
