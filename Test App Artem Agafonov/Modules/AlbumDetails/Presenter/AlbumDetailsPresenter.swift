//
//  AlbumDetailsPresenter.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 14.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import Foundation.NSIndexPath

final class AlbumDetailsPresenter {
    typealias LoadResult = AlbumInfoLoadService.AlbumInfoLoadResult
    
    // MARK: - Public instance properties
    @DelayedImmutable var view: AlbumDetailsViewInput
    @DelayedImmutable var interactor: AlbumDetailsInteractorInput
    @DelayedImmutable var router: AlbumDetailsRouterInput
    
    // MARK: - Private instance properties
    private let configuration: AlbumDetailsConfiguration
    private let viewModelFactory: AlbumDetailsViewModelFactory
    private let tagsDataSource: AlbumTagsDataSource
    private let urlhandler: URLHandler
    private let albumInfoLoadService: AlbumInfoLoadService
    private var model: AlbumDetailsViewModel?
    private var albumId: PSObjectID?
    private var albumExtendedInfo: AlbumExtendedInfo?
    
    // MARK: - Init
    init(configuration: AlbumDetailsConfiguration,
         viewModelFactory: AlbumDetailsViewModelFactory,
         tagsDataSource: AlbumTagsDataSource,
         urlhandler: URLHandler,
         albumInfoLoadService: AlbumInfoLoadService) {
        self.configuration = configuration
        self.viewModelFactory = viewModelFactory
        self.tagsDataSource = tagsDataSource
        self.urlhandler = urlhandler
        self.albumInfoLoadService = albumInfoLoadService
        albumId = configuration.id
    }
}

// MARK: - AlbumDetailsViewOutput
extension AlbumDetailsPresenter: AlbumDetailsViewOutput {
    func toggleAlbumIsSaved() {
        if albumId != nil {
            removeAlbum()
        } else {
            saveAlbum()
        }
    }
    
    func closeButtonTapped() {
        router.close()
    }
    
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
    func failedToSaveAlbum() {
        router.showBasicFailureAlert()
    }
    
    func removedAlbum() {
        albumId = nil
        view.update(albumSaved: false)
        router.close()
    }
    
    func savedAlbum(id: PSObjectID) {
        albumId = id
        view.update(albumSaved: true)
    }
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
            view.update(albumSaved: true)
            handleDetailsLoaded(viewModel: viewModelFactory.viewModel(entity: entity))
        } else {
            loadAlbumInfoFromNetwork()
        }
    }
    
    func loadAlbumInfoFromNetwork() {
        guard let artist = self.configuration.artist else {
            view.showNoDataPlaceholder()
            return
        }
        let completion: (LoadResult) -> Void = { [weak self] result in
            guard let self = self else { return }
            guard case .success(let info) = result else {
                DispatchQueue.main.async {
                    self.view.showNoDataPlaceholder()
                }
                return
            }
            let viewModel = self.viewModelFactory.viewModel(albumExtendedInfo: info,
                                                            artist: artist)
            DispatchQueue.main.async {
                self.handleDetailsLoaded(viewModel: viewModel)
            }
        }
        
        if let mbid = configuration.mbid {
            albumInfoLoadService.loadAlbumInfo(mbid: mbid, completion: completion)
        } else {
            guard let name = configuration.name else {
                view.showNoDataPlaceholder()
                return
            }
            albumInfoLoadService.loadAlbumInfo(artist: artist.name,
                                               album: name,
                                               completion: completion)
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
    
    func removeAlbum() {
        guard let id = albumId else {
            return
        }
        interactor.removeAlbum(with: id)
    }
    
    func saveAlbum() {
        guard let artist = configuration.artist,
            let albumInfo = albumExtendedInfo else {
                router.showBasicFailureAlert()
                return
        }
        interactor.saveAlbum(album: albumInfo, artist: artist)
    }
}
