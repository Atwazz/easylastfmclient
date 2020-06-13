//
//  AlbumModel.swift
//  Easy Last FM Client
//
//  Created by Artem Agafonov on 30.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import Foundation.NSURL

struct AlbumModel {
    let name: String
    let mbid: String?
    let imageUrl: URL?
    let id: PSObjectID?
}
