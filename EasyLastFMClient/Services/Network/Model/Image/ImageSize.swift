//
//  ImageSize.swift
//  Easy Last FM Client
//
//  Created by Artem Agafonov on 15.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

enum ImageSize: String, Decodable {
    case small
    case medium
    case large
    case extraLarge = "extralarge"
    case mega
    case `default` = ""
}
