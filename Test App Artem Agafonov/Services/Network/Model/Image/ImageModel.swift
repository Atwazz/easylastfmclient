//
//  ImageModel.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 15.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import Foundation.NSURL

struct ImageModel {
    let url: URL?
    let size: ImageSize
}

// MARK: - Decodable
extension ImageModel: Decodable {
    enum CodingKeys: String, CodingKey {
        case url = "#text"
        case size
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        url = try container.decodeURLFromString(forKey: .url)
        size = try container.decode(ImageSize.self, forKey: .size)
    }
}
