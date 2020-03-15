//
//  APIMethod.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 15.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

enum APIMethod: String, Encodable {
    case artistsSearch = "artist.search"
    case artistsGetTopAlbums = "artist.getTopAlbums"
    case albumGetInfo = "album.getInfo"
}
