//
//  MainScreenPresenter.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 14.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import Foundation.NSIndexPath

final class MainScreenPresenter {
    // MARK: - Public instance properties
    @DelayedImmutable var view: MainScreenViewInput
    @DelayedImmutable var interactor: MainScreenInteractorInput
    @DelayedImmutable var router: MainScreenRouterInput
    
    // MARK: - Private instance properties
    private let storageStateEmitter: PersistentStorageStateEmitter
    private let dataSource: MainScreenCollectionViewDataSource
    private var disposeBag = DisposeBag()
    
    // MARK: - Init
    init(storageStateEmitter: PersistentStorageStateEmitter,
         dataSource: MainScreenCollectionViewDataSource) {
        self.storageStateEmitter = storageStateEmitter
        self.dataSource = dataSource
    }
}

// MARK: - MainScreenViewOutput
extension MainScreenPresenter: MainScreenViewOutput {
    func didSelectItem(at inedxPath: IndexPath) {
        router.showAlbumDetails(id: dataSource.albumID(at: inedxPath))
    }
    
    func openSearchButtonTapped() {
        router.showSearchScreen()
    }
    
    func viewIsReady() {
        view.showLoadingIndicator()
        subscribeToPersistentStorageState()
    }
}

// MARK: - MainScreenInteractorOutput
extension MainScreenPresenter: MainScreenInteractorOutput {
    
}

// MARK: - MainScreenRouterOutput
extension MainScreenPresenter: MainScreenRouterOutput {
    
}

// MARK: - Private: Subscriptions
private extension MainScreenPresenter {
    func subscribeToPersistentStorageState() {
        storageStateEmitter.state
            .filter { $0 != .unknown }
            .sink(on: .main) { [weak self] state in
                self?.handlePersistentStorageState(state)
            }
            .store(in: &disposeBag)
    }
}

// MARK: - Private
private extension MainScreenPresenter {
    func handlePersistentStorageState(_ newState: PersistentStorageState) {
        switch newState {
        case .loadFailed(error: let error):
            router.showAlertWithError(error) { [weak self] in
                self?.view.hideLoadingIndicator()
            }
        case .loaded:
            loadAlbums()
        default:
            fatalError("Unexpected storage state: \(newState)")
        }
    }
    
    func loadAlbums() {
        setupDataSource()
        view.setup(dataSource: dataSource)
        view.hideLoadingIndicator()
    }
    
    func setupDataSource() {
        dataSource.fetchedResultsController = interactor.obtainResultControllerForAlbums()
        dataSource.loadData()
    }
}
