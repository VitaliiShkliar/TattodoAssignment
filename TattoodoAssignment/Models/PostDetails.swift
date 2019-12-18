//
//  TattooDetails.swift
//  TatoodoAssignment
//
//  Created by Vitalii Shkliar on 17.12.2019.
//  Copyright © 2019 Vitalii Shkliar. All rights reserved.
//

import Foundation

struct PostDetails: Decodable {
    let id: Int
    let artist: Artist
    let counts: PostCounts
    
    static var mock: PostDetails {
        PostDetails(id: 11, artist: Artist.mock, counts: PostCounts(likes: 1, comments: 0, pins: 0))
    }
}

struct PostDetailsContainer: Decodable {
    let data: PostDetails
}

struct Artist: Decodable {
    let id: Int
    let name: String
    let username: String
    let imageUrl: String
    
    static var mock: Artist {
        Artist(id: 111,
               name: "Test Name",
               username: "User Name",
               imageUrl: "https://tattoodo-mobile-app.imgix.net/images/profile/images/12523663_469364879913334_1062293922_a_Wz9L6nhsN5.jpg")
    }
}

struct PostCounts: Decodable {
    let likes: Int
    let comments: Int
    let pins: Int
}
