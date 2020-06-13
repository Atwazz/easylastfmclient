//
//  AlbumEntityFetcherBase.swift
//  Easy Last FM Client
//
//  Created by Artem Agafonov on 30.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import CoreData.NSFetchRequest

struct AlbumEntityFetcherBase { }

// MARK: - AlbumEntityFetcher
extension AlbumEntityFetcherBase: AlbumEntityFetcher {
    func fetchAlbum(representing model: Album, artistId: PSObjectID) -> AlbumEntity? {
        let request = AlbumEntity.fetchRequest(mbid: model.mbid, name: model.name, url: model.url, artistId: artistId)
        return execute(request: request)
    }
    
    func fetchAlbum(representing model: AlbumExtendedInfo, artistId: PSObjectID) -> AlbumEntity? {
        let request = AlbumEntity.fetchRequest(mbid: model.mbid, name: model.name, url: model.url, artistId: artistId)
        return execute(request: request)
    }
}

// MARK: - Private
private extension AlbumEntityFetcherBase {
    func execute(request: NSFetchRequest<AlbumEntity>) -> AlbumEntity? {
        do {
            return try request.execute().first
        } catch {
            fatalError("Unresolved error \(error), \(error.localizedDescription)")
        }
    }
}
