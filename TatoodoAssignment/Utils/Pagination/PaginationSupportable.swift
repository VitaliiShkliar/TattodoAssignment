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
