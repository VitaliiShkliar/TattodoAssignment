//
//  URLRequestError.swift
//  RXMVVMC
//
//  Created by Vitalii Shkliar on 06.11.2019.
//  Copyright © 2019 Vitalii Shkliar. All rights reserved.
//
import Foundation

enum URLRequestError: Error {
    case badRequest(statusCode: Int)
    case internalServerError
    case outdated
    case unknown
    case noData
}

extension URLRequestError: LocalizedError {
    var errorDescription: String? {
        // TODO: - get normal texts
        switch self {
        case .badRequest(let statusCode):
            return "Request failed with statusCode: \(statusCode)"
        case .internalServerError:
            return "Internal server error occured"
        case .outdated:
            return "Request outdeted"
        case .unknown:
            return "Something went wrong"
        case .noData:
            return "No data"
        }
    }
}
