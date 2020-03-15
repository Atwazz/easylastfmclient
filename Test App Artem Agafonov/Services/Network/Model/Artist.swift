//
//  Artist.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 15.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

struct Artist {
    let name: String
    let mbid: String
    let url: String
    let images: [ImageModel]
}

// MARK: - Decodable
extension Artist: Decodable {
    enum CodingKeys: String, CodingKey {
        case name
        case mbid
        case url
        case images = "image"
    }
}
