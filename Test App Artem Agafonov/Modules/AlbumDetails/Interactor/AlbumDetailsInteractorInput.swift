//
//  AlbumDetailsInteractorInput.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 14.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

protocol AlbumDetailsInteractorInput {
    func obtainAlbum(with id: PSObjectID) -> AlbumEntity?
    func removeAlbum(with id: PSObjectID)
    func saveAlbum(album: AlbumExtendedInfo, artist: Artist)
    func loadAlbumInfo(name: String, mbid: String?, artist: Artist)
}
