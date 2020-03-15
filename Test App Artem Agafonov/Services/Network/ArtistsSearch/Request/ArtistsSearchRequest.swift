//
//  ArtistsSearchRequest.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 15.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

struct ArtistsSearchRequest: APICommonParams {
    // MARK: - Public instance properties
    let searchText: String
    let page: UInt?
    let limit: UInt?
    
    // MARK: - APICommonParams
    let method: APIMethod
    let format: String
    let apiKey: String
    
    // MARK: - Init
    init(searchText: String,
         page: UInt?,
         limit: UInt?,
         commonParams: APICommonParams) {
        self.searchText = searchText
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
        case searchText = "artist"
        case page
        case limit
        
        // MARK: - APICommonParams
        case method
        case format
        case apiKey = "api_key"
    }
}
