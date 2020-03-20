//
//  PersistentStorageLoaderBase.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 19.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import CoreData.NSPersistentContainer

final class PersistentStorageLoaderBase {
    // MARK: - Private instance properties
    private let containerProvider: PersistentContainerProvider
    private let viewContextConfigurator: PSViewContextConfigurator
    
    // MARK: - Init
    init(persistentContainerProvider: PersistentContainerProvider,
         viewContextConfigurator: PSViewContextConfigurator) {
        containerProvider = persistentContainerProvider
        self.viewContextConfigurator = viewContextConfigurator
    }
}

// MARK: - PersistentStorageLoader
extension PersistentStorageLoaderBase: PersistentStorageLoader {
    func load(completion: @escaping (LoadResult) -> Void) {
        containerProvider.persistentContainer.loadPersistentStores { [weak self] _, error in
            guard let self = self else {
                completion(.failure(.misuseDetected))
                return
            }
            guard error == nil else {
                completion(.failure(.loadFailed))
                return
            }
            self.viewContextConfigurator.configure()
            completion(.success(()))
        }
    }
}
