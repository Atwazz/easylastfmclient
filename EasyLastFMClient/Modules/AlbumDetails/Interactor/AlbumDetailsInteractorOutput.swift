//
//  AlbumDetailsInteractorOutput.swift
//  Easy Last FM Client
//
//  Created by Artem Agafonov on 14.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

protocol AlbumDetailsInteractorOutput: class {
    func removedAlbum()
    func savedAlbum(id: PSObjectID)
    func failedToSaveAlbum()
    func failedToLoadAlbumInfo()
    func loaded(albumExtendedInfo: AlbumExtendedInfo, artist: Artist)
}
