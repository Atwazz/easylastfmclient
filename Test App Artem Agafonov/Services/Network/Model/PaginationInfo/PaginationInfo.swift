//
//  PaginationInfo.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 16.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

struct PaginationInfo {
    let page: UInt
    let pageSize: UInt
    let totalResults: UInt
}

// MARK: - Decodable
extension PaginationInfo: Decodable {
    enum CodingKeys: String, CodingKey {
        case page
        case pageSize = "perPage"
        case totalResults = "total"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        page = container.decodeUIntFromString(forKey: .page)
        pageSize = container.decodeUIntFromString(forKey: .pageSize)
        totalResults = container.decodeUIntFromString(forKey: .totalResults)
    }
}
