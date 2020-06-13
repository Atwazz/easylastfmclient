//
//  ArtistAlbumsLoadRequest.swift
//  Easy Last FM Client
//
//  Created by Artem Agafonov on 16.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

struct ArtistAlbumsLoadRequest: APICommonParams {
    // MARK: - Public instance properties
    let artistName: String?
    let artistMbid: String?
    let page: UInt?
    let limit: UInt?
    
    // MARK: - APICommonParams
    let method: APIMethod
    let format: String
    let apiKey: String
    
    // MARK: - Init
    init(artistName: String?,
         artistMbid: String?,
         page: UInt?,
         limit: UInt?,
         commonParams: APICommonParams) {
        self.artistName = artistName
        self.artistMbid = artistMbid
        self.page = page
        self.limit = limit
        method = commonParams.method
        apiKey = commonParams.apiKey
        format = commonParams.format
    }
}

// MARK: - Validatable
extension ArtistAlbumsLoadRequest: Validatable {
    func isValid() -> Bool {
        artistName != nil || artistMbid != nil
    }
}

// MARK: - Encodable
extension ArtistAlbumsLoadRequest: Encodable {
    enum CodingKeys: String, CodingKey {
        case artistName = "artist"
        case artistMbid = "mbid"
        case page
        case limit
        
        // MARK: - APICommonParams
        case method
        case format
        case apiKey = "api_key"
    }
}
