//
//  AlbumInfoLoadRequest.swift
//  Easy Last FM Client
//
//  Created by Artem Agafonov on 16.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

struct AlbumInfoLoadRequest: APICommonParams {
    // MARK: - Public instance properties
    let artist: String?
    let name: String?
    let mbid: String?
    
    // MARK: - APICommonParams
    let method: APIMethod
    let format: String
    let apiKey: String
    
    // MARK: - Init
    init(artist: String?,
         name: String?,
         mbid: String?,
         commonParams: APICommonParams) {
        self.artist = artist
        self.name = name
        self.mbid = mbid
        method = commonParams.method
        apiKey = commonParams.apiKey
        format = commonParams.format
    }
}

// MARK: - Validatable
extension AlbumInfoLoadRequest: Validatable {
    func isValid() -> Bool {
        (name != nil && artist != nil) || mbid != nil
    }
}

// MARK: - Encodable
extension AlbumInfoLoadRequest: Encodable {
    enum CodingKeys: String, CodingKey {
        case artist
        case name = "album"
        case mbid
        
        // MARK: - APICommonParams
        case method
        case format
        case apiKey = "api_key"
    }
}
