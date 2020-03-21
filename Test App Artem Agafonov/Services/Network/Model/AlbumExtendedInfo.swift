//
//  AlbumExtendedInfo.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 16.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import Foundation.NSURL

struct AlbumExtendedInfo {
    let name: String
    let artist: String
    let mbid: String?
    let url: URL?
    let images: [ImageModel]?
    let tracks: [Track]
    let tags: [Tag]?
    let wiki: Wiki?
}

// MARK: - Decodable
extension AlbumExtendedInfo: Decodable {
    enum CodingKeys: String, CodingKey {
        case name
        case artist
        case mbid
        case url
        case images = "image"
        case tracks
        case tags
        case wiki
    }
    
    enum TracksCodingKeys: String, CodingKey {
        case track
    }
    
    enum TagsCodingKeys: String, CodingKey {
        case tag
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        artist = try container.decode(String.self, forKey: .artist)
        mbid = container.decodeSafe(String.self, forKey: .mbid)
        url = container.decodeURLFromString(forKey: .url)
        images = container.decodeSafe([ImageModel].self, forKey: .images)
        wiki = container.decodeSafe(Wiki.self, forKey: .wiki)
        let tracksContainer = try container.nestedContainer(keyedBy: TracksCodingKeys.self,
                                                            forKey: .tracks)
        tracks = try tracksContainer.decode([Track].self, forKey: .track)
        let tagsContainer = try container.nestedContainer(keyedBy: TagsCodingKeys.self,
                                                          forKey: .tags)
        tags = tagsContainer.decodeSafe([Tag].self, forKey: .tag)
    }
}
