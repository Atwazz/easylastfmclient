//
//  EntryPointAssembly.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 14.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import Swinject

final class EntryPointAssembly {}

// MARK: - Assembly
extension EntryPointAssembly: Assembly {
    func assemble(container: Container) {
        registerRouter(in: container)
    }
}

// MARK: - Registrations
private extension EntryPointAssembly {
    func registerRouter(in container: Container) {
        container.register(EntryPointRouter.self) { resolver in
            let viewDispatcher = resolver.resolveSafe(ViewDispatcher.self)
            let screenFactory = resolver.resolveSafe(MainScreenFactory.self)
            return EntryPointRouterBase(viewDispatcher: viewDispatcher,
                                        initialScreenFactory: screenFactory)
        }
    }
}
