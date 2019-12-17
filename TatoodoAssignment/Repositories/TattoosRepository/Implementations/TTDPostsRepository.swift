//
//  TTDTattoosRepository.swift
//  TatoodoAssignment
//
//  Created by Vitalii Shkliar on 17.12.2019.
//  Copyright © 2019 Vitalii Shkliar. All rights reserved.
//

import Foundation

class TTDPostsRepository: PostsRepository {
    private let remoteAPI: PostsRemoteAPI
    private var detailsCache: [Int: PostDetails] = [:]
    
    init(tattoosRemoteAPI: PostsRemoteAPI) {
        remoteAPI = tattoosRemoteAPI
    }
    
    func getListOfPosts(page: Int, completion: @escaping (Result<PostsListPage, Error>) -> Void) {
        remoteAPI.getPostsList(page: page, completion: completion)
    }
    
    func getDatailsForPost(with id: Int, completion: @escaping (Result<PostDetails, Error>) -> Void) {
        if let cachedDetails = detailsCache[id] {
            completion(.success(cachedDetails))
        } else {
            remoteAPI.getDetailsForPost(with: id) { [weak self] result in
                switch result {
                case .failure(let error):
                    completion(.failure(error))
                case .success(let details):
                    self?.detailsCache[id] = details
                    completion(.success(details))
                }
            }
        }
    }
}
