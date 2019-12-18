//
//  PostsEndpoint.swift
//  TatoodoAssignment
//
//  Created by Vitalii Shkliar on 17.12.2019.
//  Copyright © 2019 Vitalii Shkliar. All rights reserved.
//

import Foundation

enum PostsEndpoint: EndPointType {
    case search(page: Int)
    case getPostDetails(postID: Int)
}

extension PostsEndpoint {
    var environmentBaseURL: String { "https://backend-api.tattoodo.com/api/v2/" }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("Failed to confugure the base URL") }
        return url
    }
    
    var path: String {
        switch self {
        case .getPostDetails(let postID):
            return "posts/\(postID)"
        case .search:
            return "search/posts"
        }
    }
    
    var httpMethod: HTTPMethod { .get }
    
    var task: HTTPTask {
        switch self {
        case .getPostDetails: return .request
        case .search(let page):
            return .requestParameters(bodyParameters: nil, urlParameters: ["page": page])
        }
    }
    
    var headers: HTTPHeaders? { nil }
}
