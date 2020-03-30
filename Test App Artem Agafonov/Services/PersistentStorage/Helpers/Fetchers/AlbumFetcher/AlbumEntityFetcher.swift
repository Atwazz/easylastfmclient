//
//  AlbumEntityFetcher.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 30.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

protocol AlbumEntityFetcher {
    func fetchAlbum(representing model: Album,
                    artistId: PSObjectID) -> AlbumEntity?
    func fetchAlbum(representing model: AlbumExtendedInfo,
                    artistId: PSObjectID) -> AlbumEntity?
}
