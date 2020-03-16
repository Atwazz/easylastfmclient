//
//  ArtistAlbumsLoadResults.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 16.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

struct ArtistAlbumsLoadResults {
    let paginationInfo: PaginationInfo
    let albums: [Album]
}

// MARK: - Decodable
extension ArtistAlbumsLoadResults: Decodable {
    enum CodingKeys: String, CodingKey {
        case albums = "album"
        case paginationInfo = "@attr"
    }
}
