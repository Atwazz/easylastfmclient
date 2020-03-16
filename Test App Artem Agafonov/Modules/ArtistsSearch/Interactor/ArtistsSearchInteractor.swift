//
//  ArtistsSearchInteractor.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 14.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

final class ArtistsSearchInteractor {
    // MARK: - Public instance properties
    weak var output: ArtistsSearchInteractorOutput?
    
    // MARK: - Private instance properties
    private let searchService: ArtistsSearchService
    
    // ONLY FOR DEBUG PURPOSES!
    private let albumLoadService: ArtistAlbumsLoadService
    
    // MARK: - Init
    init(artistsSearchService: ArtistsSearchService,
         albumLoadService: ArtistAlbumsLoadService) {
        searchService = artistsSearchService
        self.albumLoadService = albumLoadService
    }
}

// MARK: - ArtistsSearchInteractorInput
extension ArtistsSearchInteractor: ArtistsSearchInteractorInput {
    func triggerSearch(_ searchText: String, page: UInt?, pageSize: UInt?) {
        print("Searching for \(searchText)...")
        searchService.search(for: searchText, page: page, pageSize: pageSize) { [weak self] result in
            guard case .success(let results) = result else {
                print("Search failed!!!")
                return
            }
            guard let artistMbid = results.artists.first?.mbid else {
                return
            }
            self?.albumLoadService.loadAlbums(artistMbid: artistMbid, page: 1, pageSize: 50, completion: { result in
                guard case .success(let results) = result else {
                    print("Load failed!!!")
                    return
                }
                print("\(String(describing: results))")
            })
        }
    }
}
