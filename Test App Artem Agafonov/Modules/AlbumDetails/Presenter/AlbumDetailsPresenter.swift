//
//  AlbumDetailsPresenter.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 14.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import Foundation.NSIndexPath

final class AlbumDetailsPresenter {
    // MARK: - Public instance properties
    @DelayedImmutable var view: AlbumDetailsViewInput
    @DelayedImmutable var interactor: AlbumDetailsInteractorInput
    @DelayedImmutable var router: AlbumDetailsRouterInput
    
    // MARK: - Private instance properties
    private let configuration: AlbumDetailsConfiguration
    private let viewModelFactory: AlbumDetailsViewModelFactory
    private let tagsDataSource: AlbumTagsDataSource
    
    // MARK: - Init
    init(configuration: AlbumDetailsConfiguration,
         viewModelFactory: AlbumDetailsViewModelFactory,
         tagsDataSource: AlbumTagsDataSource) {
        self.configuration = configuration
        self.viewModelFactory = viewModelFactory
        self.tagsDataSource = tagsDataSource
    }
}

// MARK: - AlbumDetailsViewOutput
extension AlbumDetailsPresenter: AlbumDetailsViewOutput {
    func viewIsReady() {
        loadAlbumDetails()
    }
    
    func selectedTag(at indexPath: IndexPath) {
        // open url
    }
}

// MARK: - AlbumDetailsInteractorOutput
extension AlbumDetailsPresenter: AlbumDetailsInteractorOutput {
    
}

// MARK: - Private
private extension AlbumDetailsPresenter {
    func loadAlbumDetails() {
        view.showLoadingIndicator()
        guard configuration.isValid() else {
            view.showNoDataPlaceholder()
            return
        }
        if let id = configuration.id {
            guard let entity = interactor.obtainAlbum(with: id) else {
                view.showNoDataPlaceholder()
                return
            }
            handleDetailsLoaded(viewModel: viewModelFactory.viewModel(entity: entity))
        } else {
            // load from network
        }
    }
    
    func handleDetailsLoaded(viewModel: AlbumDetailsViewModel) {
        tagsDataSource.setup(with: viewModel.tags.sorted { $0.name < $1.name })
        view.setup(with: tagsDataSource)
        view.update(with: viewModel)
    }
}
