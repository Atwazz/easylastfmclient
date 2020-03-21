//
//  PersistentStorageAssembly.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 19.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import Swinject

final class PersistentStorageMaintanenceAssembly { }

// MARK: - Assembly
extension PersistentStorageMaintanenceAssembly: Assembly {
    func assemble(container: Container) {
        registerViewContextConfigurator(in: container)
        registerPersistentStorageLoader(in: container)
        registerMaintainer(in: container)
    }
    
    func loaded(resolver: Resolver) {
        initiateSingletons(with: resolver)
    }
}

// MARK: - Singleton initialization
private extension PersistentStorageMaintanenceAssembly {
    func initiateSingletons(with resolver: Resolver) {
        _ = resolver.resolveSafe(PersistentStorageMaintainer.self)
    }
}

// MARK: - Registrations
private extension PersistentStorageMaintanenceAssembly {
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
}
