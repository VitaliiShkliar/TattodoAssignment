//
//  TattoosRemoteAPI.swift
//  TatoodoAssignment
//
//  Created by Vitalii Shkliar on 17.12.2019.
//  Copyright © 2019 Vitalii Shkliar. All rights reserved.
//

import Foundation

protocol PostsRemoteAPI {
    func getPostsList(page: Int, completion: @escaping (Result<PostsListPage, Error>) -> Void)
    func getDetailsForPost(with id: Int, completion: @escaping (Result<PostDetails, Error>) -> Void)
}
