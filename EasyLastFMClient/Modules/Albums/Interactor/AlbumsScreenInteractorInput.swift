//
//  AlbumsScreenInteractorInput.swift
//  Easy Last FM Client
//
//  Created by Artem Agafonov on 14.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

protocol AlbumsScreenInteractorInput {
    func loadAlbums(artist: Artist, page: UInt?, pageSize: UInt?)
    func fetchArtistId(artist: Artist)
}
