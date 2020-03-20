//
//  PersistentStorageAssembly.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 19.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import Swinject

final class PersistentStorageAssembly {
    // MARK: - Private instance properties
    private let persistentContainerName = "Test_App_Artem_Agafonov"
}

// MARK: - Assembly
extension PersistentStorageAssembly: Assembly {
    func assemble(container: Container) {
        registerContainerProvider(in: container)
        registerViewContextConfigurator(in: container)
        registerPersistentStorageLoader(in: container)
        registerMaintainer(in: container)
    }
    
    func loaded(resolver: Resolver) {
        initiateSingletons(with: resolver)
    }
}

// MARK: - Singleton initialization
private extension PersistentStorageAssembly {
    func initiateSingletons(with resolver: Resolver) {
        _ = resolver.resolveSafe(PersistentStorageMaintainer.self)
    }
}

// MARK: - Registrations
private extension PersistentStorageAssembly {
    func registerContainerProvider(in container: Container) {
        container.register(PersistentContainerProvider.self) { [weak self] _ in
            guard let containerName = self?.persistentContainerName else {
                fatalError("Can't resolve persistentContainerName")
            }
            return PersistentContainerProviderBase(containerName: containerName)
        }
        .implements(ViewContextProvider.self)
        .inObjectScope(.container)
    }
    
    func registerViewContextConfigurator(in container: Container) {
        container.register(ViewContextConfigurator.self) { resolver in
            let viewContextProvider = resolver.resolveSafe(ViewContextProvider.self)
            return ViewContextConfiguratorBase(viewContextProvider: viewContextProvider)
        }
    }
    
    func registerPersistentStorageLoader(in container: Container) {
        container.register(PersistentStorageLoader.self) { resolver in
            let persistentContainerProvider = resolver.resolveSafe(PersistentContainerProvider.self)
            let viewContextConfigurator = resolver.resolveSafe(ViewContextConfigurator.self)
            return PersistentStorageLoaderBase(persistentContainerProvider: persistentContainerProvider,
                                               viewContextConfigurator: viewContextConfigurator)
        }
    }
    
    func registerMaintainer(in container: Container) {
        container.register(PersistentStorageMaintainer.self) { resolver in
            let appStateEmitter = resolver.resolveSafe(ApplicationStateEmitter.self)
            let loader = resolver.resolveSafe(PersistentStorageLoader.self)
            let viewContextProvider = resolver.resolveSafe(ViewContextProvider.self)
            return PersistentStorageMaintainer(appStateEmitter: appStateEmitter,
                                               storageLoader: loader,
                                               viewContextProvider: viewContextProvider)
        }
        .implements(PersistentStorageStateEmitter.self)
        .inObjectScope(.container)
    }
}
