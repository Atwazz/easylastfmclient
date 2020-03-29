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
    private var paginationInfo: PaginationInfo?
    
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
    func loadFailed() {
        view.showNoDataPlaceholder()
        dataSource.clearResults()
        view.reloadData()
        router.showBasicFailureAlert()
    }
    
    func loadFinished(paginationInfo: PaginationInfo, albums: [Album]) {
        view.hideLoadingIndicator()
        view.hideFooterLoadingIndicator()
        dataSource.appendResults(albums)
        self.paginationInfo = paginationInfo
        view.showResults()
    }
}

// MARK: - AlbumsScreenRouterOutput
extension AlbumsScreenPresenter: AlbumsScreenRouterOutput {
    // TODO: - Cleanup
}

// MARK; - Private
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
}
