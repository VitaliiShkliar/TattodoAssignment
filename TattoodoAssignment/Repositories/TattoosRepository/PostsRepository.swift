//
//  TattosRepository.swift
//  TatoodoAssignment
//
//  Created by Vitalii Shkliar on 17.12.2019.
//  Copyright © 2019 Vitalii Shkliar. All rights reserved.
//

import Foundation

protocol PostsRepository {
    func getListOfPosts(page: Int, completion: @escaping (Result<PostsListPage, Error>) -> Void)
    func getDatailsForPost(with id: Int, completion: @escaping (Result<PostDetails,Error>) -> Void)
}
