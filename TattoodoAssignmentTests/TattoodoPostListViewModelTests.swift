//
//  TattoodoPostListViewModelTests.swift
//  TatoodoAssignmentTests
//
//  Created by Vitalii Shkliar on 18.12.2019.
//  Copyright © 2019 Vitalii Shkliar. All rights reserved.
//

import XCTest
@testable import TattoodoAssignment

class TattoodoPostListViewModelTests: XCTestCase {
    var viewModel: PostsListControllerViewModel!
    
    override func setUp() {
        super.setUp()
        let container = AppDependencyContainer()
        let repo = container.makePostsRepository()
        viewModel = PostsListControllerViewModel(dataProvider: PostsDataProvider(repository: repo))
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func testIndexesToInsertOutput() {
        XCTAssertTrue(viewModel.numberOfRows == 0)
        let indexes = viewModel.indexesToInsert(for: 10, oldItemsCount: 0)
        let first = indexes.first?.row
        let last = indexes.last?.row
        XCTAssertTrue(first == 0)
        XCTAssertTrue(last == 9)
    }
    
}
