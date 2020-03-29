//
//  AlbumDetailsInteractor.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 14.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import Foundation

final class AlbumDetailsInteractor {
    // MARK: - Public instance properties
    weak var output: AlbumDetailsInteractorOutput?
    
    // MARK: - Private insatnce properties
    private let viewContextProvider: PSViewContextProvider
    private let backgroundTaskInvoker: PSBackgroundTaskInvoker
    private let albumsSaver: AlbumsSaver
    
    // MARK: - Init
    init(viewContextProvider: PSViewContextProvider,
         backgroundTaskInvoker: PSBackgroundTaskInvoker,
         albumsSaver: AlbumsSaver) {
        self.viewContextProvider = viewContextProvider
        self.backgroundTaskInvoker = backgroundTaskInvoker
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
}
