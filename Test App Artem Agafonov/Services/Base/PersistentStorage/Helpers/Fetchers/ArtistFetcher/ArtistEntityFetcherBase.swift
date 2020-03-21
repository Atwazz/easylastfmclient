//
//  ArtistEntityFetcherBase.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 21.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

final class ArtistEntityFetcherBase { }

// MARK: - ArtistEntityFetcher
extension ArtistEntityFetcherBase: ArtistEntityFetcher {
    func fetchArtist(representing model: Artist) -> ArtistEntity? {
        let request = ArtistEntity.fetchRequest(mbid: model.mbid, name: model.name)
        do {
            return try request.execute().first
        } catch {
            fatalError("Unresolved error \(error), \(error.localizedDescription)")
        }
    }
}
