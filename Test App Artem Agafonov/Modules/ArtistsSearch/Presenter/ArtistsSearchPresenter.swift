//
//  ArtistsSearchPresenter.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 14.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import Foundation
import Combine

final class ArtistsSearchPresenter {
    // MARK: - Private static properties
    private static let pageSize: UInt = 50
    
    // MARK: - Public instance properties
    @DelayedImmutable var view: ArtistsSearchViewInput
    @DelayedImmutable var interactor: ArtistsSearchInteractorInput
    @DelayedImmutable var router: ArtistsSearchRouterInput
    
    // MARK: - Private instance properties
    private let searchTrigger = PassthroughSubject<String, Never>()
    private let dataSource: ArtistsSearchDataSource
    private var pageIndex: UInt = 1
    private var searchText: String?
    private var paginationInfo: PaginationInfo?
    private var disposeBag = DisposeBag()
    
    // MARK: - Init
    init(dataSource: ArtistsSearchDataSource) {
        self.dataSource = dataSource
    }
}

// MARK: - ArtistsSearchViewOutput
extension ArtistsSearchPresenter: ArtistsSearchViewOutput {
    func didSelectArtist(at indexPath: IndexPath) {
        router.showAlbums(for: dataSource.item(at: indexPath))
    }
    
    func willShowArtist(at indexPath: IndexPath) {
        guard dataSource.isItemLast(at: indexPath),
            let paginationInfo = paginationInfo,
            paginationInfo.totalResults != indexPath.row + 1 else {
                return
        }
        loadNextPage()
    }
    
    func viewIsReady() {
        view.setup(with: dataSource)
    }
    
    func viewWillAppear() {
        subscribeToSearchTrigger()
    }
    
    func viewDidDisappear() {
        disposeBag.dispose()
    }
    
    func triggerSearch(_ searchText: String?) {
        guard searchText != self.searchText else {
            return
        }
        guard let searchText = searchText,
            searchText.count > 0 else {
                view.showNoDataPlaceholder()
                dataSource.clearResults()
                view.reloadData()
                return
        }
        view.showLoadingIndicator()
        dataSource.clearResults()
        view.reloadData()
        searchTrigger.send(searchText)
    }
}

// MARK: - ArtistsSearchInteractorOutput
extension ArtistsSearchPresenter: ArtistsSearchInteractorOutput {
    func searchFailed() {
        view.showNoDataPlaceholder()
        dataSource.clearResults()
        view.reloadData()
        router.showBasicFailureAlert()
    }
    
    func searchFinished(results: ArtistsSearchResults) {
        view.hideLoadingIndicator()
        view.hideFooterLoadingIndicator()
        dataSource.appendResults(results.artists)
        paginationInfo = results.paginationInfo
        view.showSearchResults()
    }
}

// MARK: - Private: Subscriptions
private extension ArtistsSearchPresenter {    
    func subscribeToSearchTrigger() {
        searchTrigger
            .debounce(for: .milliseconds(800), scheduler: RunLoop.main)
            .filter { $0.count > 2 }
            .sink { [weak self] searchText in
                self?.pageIndex = 1
                self?.searchText = searchText
                self?.view.showLoadingIndicator()
                self?.interactor.triggerSearch(searchText,
                                               page: self?.pageIndex,
                                               pageSize: Self.pageSize)
            }
            .store(in: &disposeBag)
    }
}

// MARK: - Private
private extension ArtistsSearchPresenter {
    func loadNextPage() {
        guard let searchText = searchText else {
            return
        }
        pageIndex += 1
        view.showFooterLoadingIndicator()
        interactor.triggerSearch(searchText,
                                 page: pageIndex,
                                 pageSize: Self.pageSize)
    }
}
