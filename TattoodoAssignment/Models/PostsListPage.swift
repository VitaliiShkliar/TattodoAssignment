//
//  TattooListPage.swift
//  TatoodoAssignment
//
//  Created by Vitalii Shkliar on 17.12.2019.
//  Copyright © 2019 Vitalii Shkliar. All rights reserved.
//

import Foundation

struct PostsListPage {
    let posts: [PostListModel]
    let total: Int
    let count: Int
    let currentPage: Int
    let totalPages: Int
    
    enum CodingKeys: String, CodingKey {
        case posts = "data"
        case meta
    }
}

extension PostsListPage: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let meta = try container.decode(ResponseMetadata.self, forKey: .meta)
        total = meta.pagination.total
        count = meta.pagination.count
        currentPage = meta.pagination.currentPage
        totalPages = meta.pagination.totalPages
        posts = try container.decode([PostListModel].self, forKey: .posts)
    }
}

struct ResponseMetadata: Decodable {
    let pagination: PaginationMeta
}

struct PaginationMeta: Decodable {
    let total: Int
    let count: Int
    let perPage: Int
    let currentPage: Int
    let totalPages: Int
}
