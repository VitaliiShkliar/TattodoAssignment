//
//  TTDTattoosRemoteAPI.swift
//  TatoodoAssignment
//
//  Created by Vitalii Shkliar on 17.12.2019.
//  Copyright © 2019 Vitalii Shkliar. All rights reserved.
//

import Foundation

struct TTDTattoosRemoteAPI: TattoosRemoteAPI {
    private let router: APIRouter<PostsEndpoint>
    private let responseHandler: RemoteAPIResponseHandler
    
    init(tattooRouter: APIRouter<PostsEndpoint>,
         responseHandler: RemoteAPIResponseHandler) {
        self.responseHandler = responseHandler
        router = tattooRouter
    }
    
    func getTattoosList(page: Int, completion: @escaping (Result<TattooListPage, Error>) -> Void) {
        router.request(.search(page: page),
                       responseHandler: responseHandler,
                       completion: completion)
    }
    
    func getDetailsForTattoo(with id: Int, completion: @escaping (Result<TattooDetails, Error>) -> Void) {
        router.request(.getPostDetails(postID: id), responseHandler: responseHandler, completion: completion)
    }
}
