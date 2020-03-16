//
//  AlbumExtendedInfo.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 16.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

struct AlbumExtendedInfo {
    let name: String
    let artist: String
    let mbid: String?
    let url: String?
    let images: [ImageModel]
    let tracks: [Track]
    let tags: [Tag]
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
        mbid = try container.decode(String.self, forKey: .mbid)
        url = try container.decode(String.self, forKey: .url)
        images = try container.decode([ImageModel].self, forKey: .images)
        let tracksContainer = try container.nestedContainer(keyedBy: TracksCodingKeys.self,
                                                            forKey: .tracks)
        tracks = try tracksContainer.decode([Track].self, forKey: .track)
        let tagsContainer = try container.nestedContainer(keyedBy: TagsCodingKeys.self,
                                                          forKey: .tags)
        tags = try tagsContainer.decode([Tag].self, forKey: .tag)
    }
}
