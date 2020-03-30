//
//  PersistentStorageHelpersAssembly.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 21.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import Swinject

final class PersistentStorageHelpersAssembly {
    // MARK: - Private instance properties
    private let persistentContainerName = "Test_App_Artem_Agafonov"
}

// MARK: - Assembly
extension PersistentStorageHelpersAssembly: Assembly {
    func assemble(container: Container) {
        registerContainerProvider(in: container)
        registerAlbumsSaver(in: container)
        registerAlbumRemover(in: container)
        registerAlbumFactory(in: container)
        registerArtistFetcher(in: container)
        registerAlbumEntityFetcher(in: container)
    }
}

// MARK: - Registrations
private extension PersistentStorageHelpersAssembly {
    func registerContainerProvider(in container: Container) {
        container.register(PersistentContainerProvider.self) { [persistentContainerName] _ in
            PersistentContainerProviderBase(containerName: persistentContainerName)
        }
        .implements(PSViewContextProvider.self)
        .implements(PSBackgroundTaskInvoker.self)
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
    
    func registerAlbumRemover(in container: Container) {
        container.register(AlbumRemover.self) { resolver in
            let backgroundTaskInvoker = resolver.resolveSafe(PSBackgroundTaskInvoker.self)
            return AlbumRemoverBase(backgroundTaskInvoker: backgroundTaskInvoker)
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
    
    func registerAlbumEntityFetcher(in container: Container) {
        container.register(AlbumEntityFetcher.self) { _ in
            AlbumEntityFetcherBase()
        }
    }
}
