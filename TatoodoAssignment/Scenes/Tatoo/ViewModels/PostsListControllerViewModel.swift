//
//  PostsListControllerViewModel.swift
//  TatoodoAssignment
//
//  Created by Vitalii Shkliar on 17.12.2019.
//  Copyright © 2019 Vitalii Shkliar. All rights reserved.
//

import Foundation

typealias BoolCompletion = (Bool) -> Void
typealias PostSelectedCompletion = (PostListModel) -> Void
typealias NewItemsCompletion = ([IndexPath]) -> Void

protocol PostsListControllerViewModeling: class {
    var numberOfRows: Int { get }
    var onLoadingStateChange: BoolCompletion? { get set }
    var onSelect: PostSelectedCompletion? { get set }
    var onNewItems: NewItemsCompletion? { get set }
    func getPosts()
    func didScrollToBottom()
    func userDidSelect(row: Int)
    func displayModelForCell(at row: Int) -> PostListCellDisplayModel
}

class PostsListControllerViewModel: PostsListControllerViewModeling {
    
    // MARK: - Properties
    private let dataProvider: PostsDataProvider
    var onSelect: PostSelectedCompletion?
    var onLoadingStateChange: BoolCompletion?
    var onNewItems: NewItemsCompletion?
    var numberOfRows: Int { dataProvider.dataSource.count }
    
    private var isLoading = false {
        didSet {
            onLoadingStateChange?(isLoading)
        }
    }
    
    // MARK: - Methods
    init(dataProvider: PostsDataProvider) {
        self.dataProvider = dataProvider
    }
    
    func userDidSelect(row: Int) {
        let post = dataProvider.dataSource[row]
        onSelect?(post)
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
            guard let self = self else { return }
            self.isLoading = false
            self.onNewItems?(self.indexesToInsert(for: newItems.count))
        }
    }
    
    private func indexesToInsert(for newItemsCount: Int) -> [IndexPath] {
        let oldItemsCount = self.numberOfRows - newItemsCount
        return (oldItemsCount..<self.numberOfRows).map({ IndexPath(row: $0, section: 0)})
    }
}
