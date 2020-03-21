//
//  Album.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 15.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import Foundation.NSURL

struct Album {
    let name: String
    let mbid: String?
    let url: URL?
    let images: [ImageModel]?
}

// MARK: - Decodable
extension Album: Decodable {
    enum CodingKeys: String, CodingKey {
        case name
        case mbid
        case url
        case images = "image"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        mbid = container.decodeSafe(String.self, forKey: .mbid)
        url = container.decodeURLFromString(forKey: .url)
        images = container.decodeSafe([ImageModel].self, forKey: .images)
    }
}
