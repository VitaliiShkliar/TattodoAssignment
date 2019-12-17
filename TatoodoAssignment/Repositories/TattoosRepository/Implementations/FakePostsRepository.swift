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
        completion(.success(PostsListPage(posts: Array(repeating: PostListModel.mock,
                                                         count: 10),
                                           total: 2,
                                           count: 2,
                                           currentPage: page,
                                           totalPages: 1000)))
    }
    
    func getDatailsForPost(with id: Int, completion: @escaping (Result<PostDetails, Error>) -> Void) {
        completion(.success(PostDetails.mock))
    }
    
}
