//
//  AlbumsScreenRouterInput.swift
//  Easy Last FM Client
//
//  Created by Artem Agafonov on 14.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

protocol AlbumsScreenRouterInput {
    func showBasicFailureAlert()
    func showInfo(for album: AlbumModel, artist: Artist)
}
