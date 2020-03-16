//
//  AlbumInfoLoadService.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 16.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

protocol AlbumInfoLoadService {
    typealias AlbumInfoLoadResult = Result<AlbumExtendedInfo, Error>
    
    func loadAlbumInfo(artist: String,
                       album: String,
                       completion: @escaping (AlbumInfoLoadResult) -> Void)
    
    func loadAlbumInfo(mbid: String,
                       completion: @escaping (AlbumInfoLoadResult) -> Void)
}
