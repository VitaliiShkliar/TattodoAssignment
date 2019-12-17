//
//  DefaultAPIResponseHandler.swift
//  TatoodoAssignment
//
//  Created by Vitalii Shkliar on 17.12.2019.
//  Copyright © 2019 Vitalii Shkliar. All rights reserved.
//

import Foundation

class DefaultAPIResponseHandler: RemoteAPIResponseHandler {
    func handleNetworkResponse(_ response: URLResponse?, data: Data?) -> Result<Void, Error> {
        guard let response = response as? HTTPURLResponse else { return .failure(URLRequestError.unknown) }
        switch response.statusCode {
        case 200...299: return .success(())
        case 400...499: return .failure(URLRequestError.badRequest(statusCode: response.statusCode))
        case 501...599: return .failure(URLRequestError.internalServerError)
        case 600: return .failure(URLRequestError.outdated)
        default: return .failure(URLRequestError.unknown)
        }
    }
}
