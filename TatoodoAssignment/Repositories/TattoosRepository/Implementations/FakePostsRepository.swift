//
//  FakeTattoosRepository.swift
//  TatoodoAssignment
//
//  Created by Vitalii Shkliar on 17.12.2019.
//  Copyright © 2019 Vitalii Shkliar. All rights reserved.
//

import Foundation

class FakePostsRepository: PostsRepository {
    func getListOfPosts(page: Int, completion: @escaping (Result<PostsListPage, Error>) -> Void) {
        // 0 - FOR TESTING ERROR CASE
        guard page != 0 else {
            completion(.failure(URLRequestError.badRequest(statusCode: 400)))
            return
        }
        completion(.success(PostsListPage(posts: Array(repeating: PostListModel.mock,
                                                         count: 10),
                                           total: 10 * 10,
                                           count: 10,
                                           currentPage: page,
                                           totalPages: 10)))
    }
    
    func getDatailsForPost(with id: Int, completion: @escaping (Result<PostDetails, Error>) -> Void) {
        completion(.success(PostDetails.mock))
    }
    
}
