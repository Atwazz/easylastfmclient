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
    private let urlhandler: URLHandler
    private var model: AlbumDetailsViewModel?
    
    // MARK: - Init
    init(configuration: AlbumDetailsConfiguration,
         viewModelFactory: AlbumDetailsViewModelFactory,
         tagsDataSource: AlbumTagsDataSource,
         urlhandler: URLHandler) {
        self.configuration = configuration
        self.viewModelFactory = viewModelFactory
        self.tagsDataSource = tagsDataSource
        self.urlhandler = urlhandler
    }
}

// MARK: - AlbumDetailsViewOutput
extension AlbumDetailsPresenter: AlbumDetailsViewOutput {
    func artistInfoTapped() {
        openArtistUrl()
    }
    
    func albumNameTapped() {
        openAlbumUrl()
    }
    
    func albumImageTapped() {
        openAlbumUrl()
    }
    
    func selectedTrack(with url: URL?) {
        open(url: url)
    }
    
    func viewIsReady() {
        loadAlbumDetails()
    }
    
    func selectedTag(at indexPath: IndexPath) {
        open(url: tagsDataSource.url(at: indexPath))
    }
}

// MARK: - AlbumDetailsInteractorOutput
extension AlbumDetailsPresenter: AlbumDetailsInteractorOutput {
    
}

// MARK: - AlbumDetailsRouterOutput
extension AlbumDetailsPresenter: AlbumDetailsRouterOutput {
    func confirmedOpening(url: URL) {
        urlhandler.open(url: url)
    }
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
        model = viewModel
        tagsDataSource.setup(with: viewModel.tags)
        view.setup(with: tagsDataSource)
        view.update(with: viewModel)
    }
    
    func openArtistUrl() {
        open(url: model?.artist.url)
    }
    
    func openAlbumUrl() {
        open(url: model?.url)
    }
    
    func open(url: URL?) {
        guard let url = url else {
            return
        }
        router.showOpenConfirmation(url: url)
    }
}
