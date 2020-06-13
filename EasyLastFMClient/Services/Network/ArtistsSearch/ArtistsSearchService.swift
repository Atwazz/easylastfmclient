//
//  ArtistsSearchService.swift
//  Easy Last FM Client
//
//  Created by Artem Agafonov on 15.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

protocol ArtistsSearchService {
    typealias ArtistsSearchResult = Result<ArtistsSearchResults, Error>
    
    func search(for artist: String,
                page: UInt?,
                pageSize: UInt?,
                completion: @escaping (ArtistsSearchResult) -> Void)
}
