//
//  AlbumRemoverBase.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 30.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

struct AlbumRemoverBase {
    // MARK: - Private instance properties
    private let backgroundTaskInvoker: PSBackgroundTaskInvoker
    
    // MARK: - Init
    init(backgroundTaskInvoker: PSBackgroundTaskInvoker) {
        self.backgroundTaskInvoker = backgroundTaskInvoker
    }
}

// MARK: - AlbumRemover
extension AlbumRemoverBase: AlbumRemover {
    func removeAlbum(id: PSObjectID, completion: @escaping () -> Void) {
        backgroundTaskInvoker.performBackgroundTask { context in
            guard let entity = context.albumEntity(with: id) else {
                return
            }
            guard let artistEntity = entity.artist else {
                fatalError("Database inconsistency detected!")
            }
            context.delete(entity)
            context.saveIfNeeded()
            
            if artistEntity.albums?.count == 0 {
                context.delete(artistEntity)
                context.saveIfNeeded()
            }
            
            completion()
        }
    }
}
