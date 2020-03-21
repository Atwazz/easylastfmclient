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
        registerAlbumsSaver(in: container)
        registerAlbumFactory(in: container)
        registerArtistFetcher(in: container)
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
        container.register(PersistentContainerProvider.self) { [persistentContainerName] _ in
            PersistentContainerProviderBase(containerName: persistentContainerName)
        }
        .implements(PSViewContextProvider.self)
        .implements(PSBackgroundTaskInvoker.self)
        .inObjectScope(.container)
    }
    
    func registerViewContextConfigurator(in container: Container) {
        container.register(PSViewContextConfigurator.self) { resolver in
            let viewContextProvider = resolver.resolveSafe(PSViewContextProvider.self)
            return PSViewContextConfiguratorBase(viewContextProvider: viewContextProvider)
        }
    }
    
    func registerPersistentStorageLoader(in container: Container) {
        container.register(PersistentStorageLoader.self) { resolver in
            let persistentContainerProvider = resolver.resolveSafe(PersistentContainerProvider.self)
            let viewContextConfigurator = resolver.resolveSafe(PSViewContextConfigurator.self)
            return PersistentStorageLoaderBase(persistentContainerProvider: persistentContainerProvider,
                                               viewContextConfigurator: viewContextConfigurator)
        }
    }
    
    func registerMaintainer(in container: Container) {
        container.register(PersistentStorageMaintainer.self) { resolver in
            let appStateEmitter = resolver.resolveSafe(ApplicationStateEmitter.self)
            let loader = resolver.resolveSafe(PersistentStorageLoader.self)
            let viewContextProvider = resolver.resolveSafe(PSViewContextProvider.self)
            return PersistentStorageMaintainer(appStateEmitter: appStateEmitter,
                                               storageLoader: loader,
                                               viewContextProvider: viewContextProvider)
        }
        .implements(PersistentStorageStateEmitter.self)
        .inObjectScope(.container)
    }
    
    func registerAlbumsSaver(in container: Container) {
        container.register(AlbumsSaver.self) { resolver in
            let backgroundTaskInvoker = resolver.resolveSafe(PSBackgroundTaskInvoker.self)
            let artistFetcher = resolver.resolveSafe(ArtistEntityFetcher.self)
            let albumFactory = resolver.resolveSafe(AlbumEntityFactory.self)
            return AlbumsSaverBase(backgroundTaskInvoker: backgroundTaskInvoker,
                                   artistFetcher: artistFetcher,
                                   albumFactory: albumFactory)
        }
    }
    
    func registerAlbumFactory(in container: Container) {
        container.register(AlbumEntityFactory.self) { _ in
            AlbumEntityFactoryBase()
        }
    }
    
    func registerArtistFetcher(in container: Container) {
        container.register(ArtistEntityFetcher.self) { _ in
            ArtistEntityFetcherBase()
        }
    }
}
