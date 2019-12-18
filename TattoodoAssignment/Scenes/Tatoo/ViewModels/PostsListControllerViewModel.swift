//
//  PostsListControllerViewModel.swift
//  TatoodoAssignment
//
//  Created by Vitalii Shkliar on 17.12.2019.
//  Copyright © 2019 Vitalii Shkliar. All rights reserved.
//

import Foundation

typealias StringCompletion = (String) -> Void
typealias ErrorCompletion = (Error) -> Void
typealias BoolCompletion = (Bool) -> Void
typealias PostSelectedCompletion = (PostListModel) -> Void
typealias NewItemsCompletion = ([IndexPath]) -> Void

protocol PostsListControllerViewModeling: class {
    var numberOfRows: Int { get }
    var onLoadingStateChange: BoolCompletion? { get set }
    var onPostSelected: PostSelectedCompletion? { get set }
    var onNewItems: NewItemsCompletion? { get set }
    var onErrorMessageReceived: StringCompletion? { get set }
    func getPosts()
    func didScrollToBottom()
    func userDidSelect(row: Int)
    func displayModelForCell(at row: Int) -> PostListCellDisplayModel
}

class PostsListControllerViewModel: PostsListControllerViewModeling {
    
    // MARK: - Properties
    private let dataProvider: PostsDataProvider
    var onPostSelected: PostSelectedCompletion?
    var onLoadingStateChange: BoolCompletion?
    var onNewItems: NewItemsCompletion?
    var onErrorMessageReceived: StringCompletion?
    var numberOfRows: Int { dataProvider.dataSource.count }
    
    private var isLoading = false {
        didSet {
            onLoadingStateChange?(isLoading)
        }
    }
    
    // MARK: - Methods
    init(dataProvider: PostsDataProvider) {
        self.dataProvider = dataProvider
        dataProvider.onError = { [weak self] error in
            self?.isLoading = false
            self?.onErrorMessageReceived?(error.localizedDescription)
        }
    }
    
    func userDidSelect(row: Int) {
        let post = dataProvider.dataSource[row]
        onPostSelected?(post)
    }
    
    func displayModelForCell(at row: Int) -> PostListCellDisplayModel {
        let post = dataProvider.dataSource[row]
        return PostListCellDisplayModel(for: post)
    }
    
    func didScrollToBottom() {
        getPosts()
    }
    
    func getPosts() {
        guard !isLoading else { return }
        isLoading = true
        dataProvider.queryMore { [weak self] newItems in
            self?.isLoading = false
            guard let self = self else { return }
            let oldItemsCount = self.numberOfRows - newItems.count
            self.onNewItems?(self.indexesToInsert(for: newItems.count, oldItemsCount: oldItemsCount))
        }
    }
    
    func indexesToInsert(for newItemsCount: Int, oldItemsCount: Int) -> [IndexPath] {
        guard newItemsCount > 0 else { return [] }
        return (oldItemsCount..<(oldItemsCount + newItemsCount)).map { IndexPath(row: $0, section: 0) }
    }
}
