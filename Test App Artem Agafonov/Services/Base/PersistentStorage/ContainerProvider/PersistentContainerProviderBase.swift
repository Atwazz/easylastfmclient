//
//  PersistentContainerProviderBase.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 19.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import CoreData.NSPersistentContainer

final class PersistentContainerProviderBase {
    // MARK: - Private instance properties
    private let container: NSPersistentContainer
    
    // MARK: - Init
    init(containerName: String) {
        container = NSPersistentContainer(name: containerName)
    }
}

// MARK: - PersistentContainerProvider
extension PersistentContainerProviderBase: PersistentContainerProvider {
    var persistentContainer: NSPersistentContainer {
        container
    }
}

// MARK: - PersistentStorageViewContextProvider
extension PersistentContainerProviderBase: ViewContextProvider {
    var viewContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }
}
