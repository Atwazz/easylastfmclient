//
//  MainScreenInteractor.swift
//  Easy Last FM Client
//
//  Created by Artem Agafonov on 14.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import CoreData.NSFetchedResultsController

final class MainScreenInteractor {
    // MARK: - Private instance properties
    private let viewContextProvider: PSViewContextProvider
    
    // MARK: - Init
    init(viewContextProvider: PSViewContextProvider) {
        self.viewContextProvider = viewContextProvider
    }
}

// MARK: - MainScreenInteractorInput
extension MainScreenInteractor: MainScreenInteractorInput {
    func obtainResultControllerForAlbums() -> NSFetchedResultsController<AlbumEntity> {
        NSFetchedResultsController(fetchRequest: AlbumEntity.allAlbumsFetchRequest(),
                                   managedObjectContext: viewContextProvider.viewContext,
                                   sectionNameKeyPath: nil,
                                   cacheName: nil)
    }
}
