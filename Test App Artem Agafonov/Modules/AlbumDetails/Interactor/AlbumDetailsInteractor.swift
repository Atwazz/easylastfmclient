//
//  AlbumDetailsInteractor.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 14.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import Foundation

final class AlbumDetailsInteractor {
    typealias LoadResult = AlbumInfoLoadService.AlbumInfoLoadResult
    
    // MARK: - Public instance properties
    weak var output: AlbumDetailsInteractorOutput?
    
    // MARK: - Private insatnce properties
    private let viewContextProvider: PSViewContextProvider
    private let backgroundTaskInvoker: PSBackgroundTaskInvoker
    private let albumInfoLoadService: AlbumInfoLoadService
    private let albumsSaver: AlbumsSaver
    
    // MARK: - Init
    init(viewContextProvider: PSViewContextProvider,
         backgroundTaskInvoker: PSBackgroundTaskInvoker,
         albumInfoLoadService: AlbumInfoLoadService,
         albumsSaver: AlbumsSaver) {
        self.viewContextProvider = viewContextProvider
        self.backgroundTaskInvoker = backgroundTaskInvoker
        self.albumInfoLoadService = albumInfoLoadService
        self.albumsSaver = albumsSaver
    }
}

// MARK: - AlbumDetailsInteractorInput
extension AlbumDetailsInteractor: AlbumDetailsInteractorInput {
    func obtainAlbum(with id: PSObjectID) -> AlbumEntity? {
        viewContextProvider.viewContext.albumEntity(with: id)
    }
    
    func removeAlbum(with id: PSObjectID) {
        backgroundTaskInvoker.performBackgroundTask { [weak self] context in
            guard let entity = context.albumEntity(with: id) else {
                return
            }
            context.delete(entity)
            context.saveIfNeeded()
            
            DispatchQueue.main.async {
                self?.output?.removedAlbum()
            }
        }
    }
    
    func saveAlbum(album: AlbumExtendedInfo, artist: Artist) {
        albumsSaver.save(albums: [album], for: artist) { [weak self] result in
            guard case .success(let ids) = result,
                let id = ids.first else {
                    DispatchQueue.main.async {
                        self?.output?.failedToSaveAlbum()
                    }
                    return
            }
            DispatchQueue.main.async {
                self?.output?.savedAlbum(id: id)
            }
        }
    }
    
    func loadAlbumInfo(name: String, mbid: String?, artist: Artist) {
        let completion: (LoadResult) -> Void = { [weak self] result in
            guard case .success(let info) = result else {
                DispatchQueue.main.async {
                    self?.output?.failedToLoadAlbumInfo()
                }
                return
            }
            self?.output?.loaded(albumExtendedInfo: info, artist: artist)
        }
        
        if let mbid = mbid,
            mbid.count > 0 {
            albumInfoLoadService.loadAlbumInfo(mbid: mbid, completion: completion)
        } else {
            albumInfoLoadService.loadAlbumInfo(artist: artist.name,
                                               album: name,
                                               completion: completion)
        }
    }
}
