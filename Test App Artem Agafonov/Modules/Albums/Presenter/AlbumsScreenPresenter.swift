//
//  AlbumsScreenPresenter.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 14.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import Foundation

final class AlbumsScreenPresenter {
    // MARK: - Private static properties
    private static let pageSize: UInt = 30
    
    // MARK: - Public instance properties
    @DelayedImmutable var view: AlbumsScreenViewInput
    @DelayedImmutable var interactor: AlbumsScreenInteractorInput
    @DelayedImmutable var router: AlbumsScreenRouterInput
    
    // MARK: - Private instance properties
    private let configuration: AlbumsScreenConfiguration
    private let dataSource: AlbumsScreenDataSource
    private var pageIndex: UInt = 1
    @ThreadSafe private var paginationInfo: PaginationInfo?
    @ThreadSafe private var artistId: PSObjectID?
    @ThreadSafe(wrappedValue: false) private var artistIdLoaded: Bool?
    @ThreadSafe(wrappedValue: false) private var firstPageLoaded: Bool?
    
    // MARK: - Init
    init(configuration: AlbumsScreenConfiguration,
         dataSource: AlbumsScreenDataSource) {
        self.configuration = configuration
        self.dataSource = dataSource
    }
}

// MARK: - AlbumsScreenViewOutput
extension AlbumsScreenPresenter: AlbumsScreenViewOutput {
    func viewIsReady() {
        view.setup(with: dataSource, title: artist.name)
        view.showLoadingIndicator()
        interactor.fetchArtistId(artist: artist)
        interactor.loadAlbums(artist: artist,
                              page: pageIndex,
                              pageSize: Self.pageSize)
    }
    
    func didSelectAlbum(at indexPath: IndexPath) {
        showDetails(for: dataSource.item(at: indexPath))
    }
    
    func willShowAlbum(at indexPath: IndexPath) {
        guard dataSource.isItemLast(at: indexPath),
            let paginationInfo = paginationInfo,
            paginationInfo.totalResults != indexPath.row + 1 else {
                return
        }
        loadNextPage()
    }
}

// MARK: - AlbumsScreenInteractorOutput
extension AlbumsScreenPresenter: AlbumsScreenInteractorOutput {
    func fetchedArtistId(_ id: PSObjectID?) {
        artistId = id
        dataSource.updateArtistId(id)
        artistIdLoaded = true
        DispatchQueue.main.async {
            self.hideLoadingIndicatorsIfNeeded()
        }
    }
    
    func loadFailed() {
        DispatchQueue.main.async {
            self.view.showNoDataPlaceholder()
            self.dataSource.clearResults()
            self.view.reloadData()
            self.router.showBasicFailureAlert()
        }
    }
    
    func loadFinished(paginationInfo: PaginationInfo, albums: [Album]) {
        self.paginationInfo = paginationInfo
        if pageIndex == 1 {
            firstPageLoaded = true
        }
        DispatchQueue.main.async {
            self.dataSource.appendResults(albums)
            self.view.hideNoDataPlaceholder()
            self.hideLoadingIndicatorsIfNeeded()
        }
    }
}

// MARK: - AlbumsScreenRouterOutput
extension AlbumsScreenPresenter: AlbumsScreenRouterOutput {
    // TODO: - Cleanup
}

// MARK: - Private
private extension AlbumsScreenPresenter {
    var artist: Artist {
        configuration.artist
    }
    
    func showDetails(for album: Album) {
        // TODO:
    }
    
    func loadNextPage() {
        pageIndex += 1
        view.showFooterLoadingIndicator()
        interactor.loadAlbums(artist: artist,
                              page: pageIndex,
                              pageSize: Self.pageSize)
    }
    
    func hideLoadingIndicatorsIfNeeded() {
        guard let firstPageLoaded = firstPageLoaded,
            let artistIdLoaded = artistIdLoaded,
            firstPageLoaded && artistIdLoaded else {
                return
        }
        view.hideLoadingIndicator()
        view.hideFooterLoadingIndicator()
        view.reloadData()
    }
}
