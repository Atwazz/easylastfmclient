//
//  ArtistEntityFetcher.swift
//  Easy Last FM Client
//
//  Created by Artem Agafonov on 21.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

protocol ArtistEntityFetcher {
    func fetchArtist(representing model: Artist) -> ArtistEntity?
}
