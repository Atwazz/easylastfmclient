//
//  ArtistsSearchResults.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 15.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

struct ArtistsSearchResults {
    let paginationInfo: PaginationInfo
    let artists: [Artist]
}

// MARK: - Decodable
extension ArtistsSearchResults: Decodable {
    enum CodingKeys: String, CodingKey {
        case searchQuery = "opensearch:Query"
        case totalResults = "opensearch:totalResults"
        case pageSize = "opensearch:itemsPerPage"
        case matches = "artistmatches"
    }
    
    enum MatchingCodingKeys: String, CodingKey {
        case artists = "artist"
    }
    
    enum QueryCodingKeys: String, CodingKey {
      case page = "startPage"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let queryContainer = try container.nestedContainer(keyedBy: QueryCodingKeys.self,
                                                           forKey: .searchQuery)
        let page = try queryContainer.decodeUIntFromString(forKey: .page)
        let totalResults = try container.decodeUIntFromString(forKey: .totalResults)
        let pageSize = try container.decodeUIntFromString(forKey: .pageSize)
        let matchesContainer = try container.nestedContainer(keyedBy: MatchingCodingKeys.self,
                                                             forKey: .matches)
        artists = try matchesContainer.decode([Artist].self, forKey: .artists)
        paginationInfo = PaginationInfo(page: page,
                                        pageSize: pageSize,
                                        totalResults: totalResults)
    }
}
