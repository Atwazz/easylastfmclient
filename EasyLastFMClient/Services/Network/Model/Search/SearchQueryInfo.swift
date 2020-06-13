//
//  SearchQueryInfo.swift
//  Easy Last FM Client
//
//  Created by Artem Agafonov on 15.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

struct SearchQueryInfo {
    let searchTerms: String
    let page: UInt
}

// MARK: - Decodable
extension SearchQueryInfo: Decodable {
    enum CodingKeys: String, CodingKey {
      case searchTerms
      case page = "startPage"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        searchTerms = try container.decode(String.self, forKey: .searchTerms)
        page = container.decodeUIntFromString(forKey: .page)
    }
}
