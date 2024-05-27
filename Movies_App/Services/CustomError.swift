//
//  CustomError.swift
//  Movies_App
//
//  Created by Kavin on 09/05/24.
//

import Foundation

enum NetworkingError: Error{
    
    case badURL
    case pageNotFound
    case internalServerError
    case errorValues(error: Error)
}

extension NetworkingError: LocalizedError{
    public var errorDescription: String? {
        switch self {
        case .badURL:
            return "Bad URL"
        case .pageNotFound:
            return "Page not found"
        case .internalServerError:
            return "server down, Please try again later"
        default :
            return "Somathing went wrong, please try again later!"
        }
    }
}
