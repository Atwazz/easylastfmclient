//
//  AlbumDetailsViewModel.swift
//  Easy Last FM Client
//
//  Created by Artem Agafonov on 28.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import Foundation.NSURL

struct AlbumDetailsViewModel {
    let name: String
    let url: URL?
    let imageURL: URL?
    let tracks: [TrackViewModel]
    let tags: [TagViewModel]
    let artist: ArtistViewModel
    let published: String?
    let summary: String?
}
