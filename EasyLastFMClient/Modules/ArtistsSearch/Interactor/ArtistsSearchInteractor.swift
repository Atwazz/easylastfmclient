//
//  ArtistsSearchInteractor.swift
//  Easy Last FM Client
//
//  Created by Artem Agafonov on 14.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import Foundation

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
        searchService.search(for: searchText, page: page, pageSize: pageSize) { [weak self] result in
            guard case .success(let results) = result else {
                DispatchQueue.main.async {
                    self?.output?.searchFailed()
                }
                return
            }
            DispatchQueue.main.async {
                self?.output?.searchFinished(results: results)
            }
        }
    }
}
