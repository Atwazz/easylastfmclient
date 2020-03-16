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
    
    // MARK: - Init
    init(artistsSearchService: ArtistsSearchService) {
        searchService = artistsSearchService
    }
}

// MARK: - ArtistsSearchInteractorInput
extension ArtistsSearchInteractor: ArtistsSearchInteractorInput {
    func triggerSearch(_ searchText: String, page: UInt?, pageSize: UInt?) {
        print("Searching for \(searchText)...")
        searchService.search(for: searchText, page: page, pageSize: pageSize) { result in
            guard case .success(_) = result else {
                print("Search failed!!!")
                return
            }
        }
    }
}
