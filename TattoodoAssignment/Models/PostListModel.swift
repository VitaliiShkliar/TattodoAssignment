//
//  TattooListModel.swift
//  TatoodoAssignment
//
//  Created by Vitalii Shkliar on 17.12.2019.
//  Copyright © 2019 Vitalii Shkliar. All rights reserved.
//

import Foundation

struct PostListModel: Decodable {
    let id: Int
    let description: String
    let image: PostImage
    let updatedAt: Date
    let classification: Classification
}

extension PostListModel {
    static var mock: PostListModel {
        PostListModel(id: 0, description: "Test description",
                        image: PostImage.mock,
                        updatedAt: Date(),
                        classification: Classification(hashtags: [], styles: [], motifs: []))
    }
}

struct PostImage: Decodable {
    let url: String
    let width: Int
    let height: Int
}

extension PostImage {
    static var mock: PostImage {
        PostImage(url: "https://tattoodo-mobile-app.imgix.net/images/posts/20180727_dah3TrUm5beLi9f.jpg",
                  width: 1080,
                  height: 810)
    }
}

struct Classification: Decodable {
    let hashtags: [String]
    let styles: [String]
    let motifs: [String]
    
}
