//
//  PaginationSupportable.swift
//  TatoodoAssignment
//
//  Created by Vitalii Shkliar on 17.12.2019.
//  Copyright © 2019 Vitalii Shkliar. All rights reserved.
//

import Foundation
protocol PaginationSupportable {
    associatedtype PaginatedItem
    associatedtype Request
    var dataSource: [PaginatedItem] { get set }
    var currentPage: Int { get }
    var request: Request { get }
    func getData(request: Request, completion: @escaping ([PaginatedItem]) -> Void)
}

extension PaginationSupportable {
    func queryMore(completion: @escaping ([PaginatedItem]) -> Void) {
        getData(request: request, completion: completion)
    }
}

class PostsDataProvider: PaginationSupportable {
    typealias PaginatedItem = PostListModel
    private let repo: PostsRepository
    private var loadedPages: [PostsListPage] = []
    var dataSource: [PostListModel] = []
    var currentPage: Int { loadedPages.count }
    var request: Int { currentPage + 1 }
    private var totalPages: Int? { loadedPages.first?.totalPages }
    var onError: ErrorCompletion?
    
    init(repository: PostsRepository) {
        repo = repository
    }
    
    func getData(request: Int, completion: @escaping ([PostListModel]) -> Void) {
        if let total = totalPages, currentPage == total { return }
        let old = self.dataSource
        self.repo.getListOfPosts(page: request) { [weak self] result in
            switch result {
            case .failure(let error):
                self?.onError?(error)
            case .success(let page):
                self?.loadedPages.append(page)
                let newPosts = page.posts
                self?.dataSource = old + newPosts
                completion(newPosts)
            }
        }
    }
}
