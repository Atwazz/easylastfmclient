//
//  ArtistsSearchAssembly.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 14.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import Swinject

final class ArtistsSearchAssembly { }

// MARK: - Assembly
extension ArtistsSearchAssembly: Assembly {
    func assemble(container: Container) {
        registerView(in: container)
        registerInteractor(in: container)
        registerPresenter(in: container)
        registerRouter(in: container)
    }
}

// MARK: - Registrations
private extension ArtistsSearchAssembly {
    func registerView(in container: Container) {
        container.register(ArtistsSearchViewInput.self) { resolver in
            let viewOutput = resolver.resolveSafe(ArtistsSearchViewOutput.self)
            return ArtistsSearchViewController(output: viewOutput)
        }
    }
    
    func registerInteractor(in container: Container) {
        container.register(ArtistsSearchInteractorInput.self) { resolver in
            let output = resolver.resolveSafe(ArtistsSearchInteractorOutput.self)
            return ArtistsSearchInteractor(output: output)
        }
    }
    
    func registerPresenter(in container: Container) {
        container.register(ArtistsSearchViewOutput.self) { resolver in
            let view = resolver.resolveSafe(ArtistsSearchViewInput.self)
            let interactor = resolver.resolveSafe(ArtistsSearchInteractorInput.self)
            let router = resolver.resolveSafe(ArtistsSearchRouterInput.self)
            return ArtistsSearchPresenter(view: view,
                                          interactor: interactor,
                                          router: router)
        }
        .implements(ArtistsSearchInteractorOutput.self)
        .implements(ArtistsSearchRouterOutput.self)
    }
    
    func registerRouter(in container: Container) {
        container.register(ArtistsSearchRouterInput.self) { resolver in
            let output = resolver.resolveSafe(ArtistsSearchRouterOutput.self)
            return ArtistsSearchRouter(output: output)
        }
    }
}
