//
//  TattooListCellDisplayModel.swift
//  TatoodoAssignment
//
//  Created by Vitalii Shkliar on 17.12.2019.
//  Copyright © 2019 Vitalii Shkliar. All rights reserved.
//

import Foundation

struct PostListCellDisplayModel {
    let imageURL: URL?
    let text: String
    
    init(for post: PostListModel) {
        imageURL = URL(string: post.image.url)
        text = post.description
    }
}
