//
//  SearchQueryInfo.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 15.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

struct SearchQueryInfo {
    let searchTerms: String
    let startPage: UInt
}

// MARK: - Decodable
extension SearchQueryInfo: Decodable {
    enum CodingKeys: String, CodingKey {
      case searchTerms
      case startPage
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        searchTerms = try container.decode(String.self, forKey: .searchTerms)
        startPage = try container.decodeUintFromString(forKey: .startPage)
    }
}
