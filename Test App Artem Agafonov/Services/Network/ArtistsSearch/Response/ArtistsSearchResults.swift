//
//  ArtistsSearchResults.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 15.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

struct ArtistsSearchResults {
    let searchQueryInfo: SearchQueryInfo
    let totalResults: UInt
    let startIndex: UInt
    let itemsPerPage: UInt
    let artists: [Artist]
}

// MARK: - Decodable
extension ArtistsSearchResults: Decodable {
    enum CodingKeys: String, CodingKey {
        case searchQueryInfo = "opensearch:Query"
        case totalResults = "opensearch:totalResults"
        case startIndex = "opensearch:startIndex"
        case itemsPerPage = "opensearch:itemsPerPage"
        case matches = "artistmatches"
    }
    
    enum MatchingCodingKeys: String, CodingKey {
        case artists = "artist"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        searchQueryInfo = try container.decode(SearchQueryInfo.self, forKey: .searchQueryInfo)
        totalResults = try container.decodeUintFromString(forKey: .totalResults)
        startIndex = try container.decodeUintFromString(forKey: .startIndex)
        itemsPerPage = try container.decodeUintFromString(forKey: .itemsPerPage)
        let matchesContainer = try container.nestedContainer(keyedBy: MatchingCodingKeys.self, forKey: .matches)
        artists = try matchesContainer.decode([Artist].self, forKey: .artists)
    }
}
