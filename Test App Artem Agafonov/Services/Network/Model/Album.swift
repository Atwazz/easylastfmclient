//
//  Album.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 15.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

struct Album {
    let name: String
    let mbid: String?
    let url: String?
    let artist: Artist
    let images: [ImageModel]?
}

// MARK: - Decodable
extension Album: Decodable {
    enum CodingKeys: String, CodingKey {
        case name
        case mbid
        case url
        case artist
        case images = "image"
    }
}
