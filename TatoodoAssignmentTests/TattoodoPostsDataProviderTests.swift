//
//  TattoodoPostsDataProviderTests.swift
//  TatoodoAssignmentTests
//
//  Created by Vitalii Shkliar on 18.12.2019.
//  Copyright © 2019 Vitalii Shkliar. All rights reserved.
//

import XCTest
@testable import TatoodoAssignment

class TattoodoPostsDataProviderTests: XCTestCase {
    var provider: PostsDataProvider!
    
    override func setUp() {
        super.setUp()
        let container = AppDependencyContainer()
        let repository = container.makePostsRepository()
        provider = PostsDataProvider(repository: repository)
    }
    
    override func tearDown() {
        provider = nil
        super.tearDown()
    }
    
    func testPageIncreasesOnSuccessResponse() {
        let initialCurrentPage = provider.currentPage
        XCTAssert(initialCurrentPage == 0)
        let promise = expectation(description: "Current page increased")
        provider.getData(request: 1) { _ in
            promise.fulfill()
        }
        wait(for: [promise], timeout: 2)
        let newCurrentPage = provider.currentPage
        let diff = newCurrentPage - initialCurrentPage
        XCTAssert(diff == 1)
    }
    
    func testTotalPagesValueIsNotNilAfterSuccessfulRequest() {
        let initialValue = provider.totalPages
        XCTAssertNil(initialValue)
        let promise = expectation(description: "total pages did set")
        provider.getData(request: 1) { _ in
            promise.fulfill()
        }
        wait(for: [promise], timeout: 1)
        XCTAssertNotNil(provider.totalPages)
    }
    
    func testItemsCountIncreasesOnSuccessfulRequest() {
        let initialValue = provider.dataSource.count
        XCTAssert(initialValue == 0)
        let promise = expectation(description: "items added set")
        provider.getData(request: 1) { _ in
            promise.fulfill()
        }
        wait(for: [promise], timeout: 1)
        XCTAssert(provider.dataSource.count > initialValue)
    }
    
    func testErrorCase() {
        var error: Error?
        let promise = expectation(description: "error received")
        provider.onError = { err in
            error = err
            promise.fulfill()
        }
        // 0 - for error case
        provider.getData(request: 0) { _ in  }
        wait(for: [promise], timeout: 1)
        XCTAssertNotNil(error)
    }
}
