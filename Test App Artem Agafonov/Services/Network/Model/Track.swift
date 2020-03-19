//
//  Track.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 16.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import Foundation.NSURL

struct Track {
    let name: String
    let url: URL?
    let duration: UInt
    let rank: UInt
    let artist: Artist
}

// MARK: - Decodable
extension Track: Decodable {
    enum CodingKeys: String, CodingKey {
        case name
        case url
        case duration
        case rankContainer = "@attr"
        case artist
    }
    
    enum RankContainerCodingKeys: String, CodingKey {
        case rank
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        url = try container.decodeURLFromString(forKey: .url)
        duration = try container.decodeUIntFromString(forKey: .duration)
        artist = try container.decode(Artist.self, forKey: .artist)
        let rankContainer = try container.nestedContainer(keyedBy: RankContainerCodingKeys.self,
                                                          forKey: .rankContainer)
        rank = try rankContainer.decodeUIntFromString(forKey: .rank)
    }
}
