//
//  ImageModel.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 15.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

struct ImageModel {
    let url: String
    let size: ImageSize
}

// MARK: - Decodable
extension ImageModel: Decodable {
    enum CodingKeys: String, CodingKey {
        case url = "#text"
        case size
    }
}
