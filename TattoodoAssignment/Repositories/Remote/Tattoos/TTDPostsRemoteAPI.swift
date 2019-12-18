//
//  TTDTattoosRemoteAPI.swift
//  TatoodoAssignment
//
//  Created by Vitalii Shkliar on 17.12.2019.
//  Copyright © 2019 Vitalii Shkliar. All rights reserved.
//

import Foundation

struct TTDPostsRemoteAPI: PostsRemoteAPI {
    private let router: APIRouter<PostsEndpoint>
    private let responseHandler: RemoteAPIResponseHandler
    
    init(tattooRouter: APIRouter<PostsEndpoint>,
         responseHandler: RemoteAPIResponseHandler) {
        self.responseHandler = responseHandler
        router = tattooRouter
    }
    
    func getPostsList(page: Int, completion: @escaping (Result<PostsListPage, Error>) -> Void) {
        router.request(.search(page: page),
                       responseHandler: responseHandler,
                       completion: completion)
    }
    
    func getDetailsForPost(with id: Int, completion: @escaping (Result<PostDetails, Error>) -> Void) {
        router.request(.getPostDetails(postID: id),
                       responseHandler: responseHandler,
                       completion: { (result: Result<PostDetailsContainer, Error>) in
                        switch result {
                        case .success(let container):
                            completion(.success(container.data))
                        case .failure(let error):
                            completion(.failure(error))
                        }
        })
    }
}
