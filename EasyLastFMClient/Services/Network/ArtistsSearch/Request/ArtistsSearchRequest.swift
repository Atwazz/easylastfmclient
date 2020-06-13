//
//  ArtistsSearchRequest.swift
//  Easy Last FM Client
//
//  Created by Artem Agafonov on 15.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

struct ArtistsSearchRequest: APICommonParams {
    // MARK: - Public instance properties
    let artist: String
    let page: UInt?
    let limit: UInt?
    
    // MARK: - APICommonParams
    let method: APIMethod
    let format: String
    let apiKey: String
    
    // MARK: - Init
    init(artist: String,
         page: UInt?,
         limit: UInt?,
         commonParams: APICommonParams) {
        self.artist = artist
        self.page = page
        self.limit = limit
        method = commonParams.method
        apiKey = commonParams.apiKey
        format = commonParams.format
    }
}

// MARK: - Encodable
extension ArtistsSearchRequest: Encodable {
    enum CodingKeys: String, CodingKey {
        case artist
        case page
        case limit
        
        // MARK: - APICommonParams
        case method
        case format
        case apiKey = "api_key"
    }
}
