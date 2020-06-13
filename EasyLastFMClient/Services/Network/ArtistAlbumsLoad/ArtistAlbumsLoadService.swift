//
//  ArtistAlbumsLoadService.swift
//  Easy Last FM Client
//
//  Created by Artem Agafonov on 16.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

protocol ArtistAlbumsLoadService {
    typealias AlbumsLoadResult = Result<ArtistAlbumsLoadResults, Error>
    
    func loadAlbums(artistMbid: String,
                    page: UInt?,
                    pageSize: UInt?,
                    completion: @escaping (AlbumsLoadResult) -> Void)
    
    func loadAlbums(artistName: String,
                    page: UInt?,
                    pageSize: UInt?,
                    completion: @escaping (AlbumsLoadResult) -> Void)
}
