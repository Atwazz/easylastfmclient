//
//  ArtistAlbumsLoadResponse.swift
//  Easy Last FM Client
//
//  Created by Artem Agafonov on 16.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

struct ArtistAlbumsLoadResponse {
    let results: ArtistAlbumsLoadResults
}

// MARK: - Decodable
extension ArtistAlbumsLoadResponse: Decodable {
    enum CodingKeys: String, CodingKey {
        case results = "topalbums"
    }
}
