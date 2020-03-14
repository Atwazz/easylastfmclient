//
//  AlbumsScreenAssembly.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 14.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import Swinject

final class AlbumsScreenAssembly { }

// MARK: - Assembly
extension AlbumsScreenAssembly: Assembly {
    func assemble(container: Container) {
        registerView(in: container)
        registerInteractor(in: container)
        registerPresenter(in: container)
        registerRouter(in: container)
    }
}

// MARK: - Registrations
private extension AlbumsScreenAssembly {
    func registerView(in container: Container) {
        container.register(AlbumsScreenViewInput.self) { resolver in
            let viewOutput = resolver.resolveSafe(AlbumsScreenViewOutput.self)
            return AlbumsScreenViewController(output: viewOutput)
        }
    }
    
    func registerInteractor(in container: Container) {
        container.register(AlbumsScreenInteractorInput.self) { resolver in
            let output = resolver.resolveSafe(AlbumsScreenInteractorOutput.self)
            return AlbumsScreenInteractor(output: output)
        }
    }
    
    func registerPresenter(in container: Container) {
        container.register(AlbumsScreenViewOutput.self) { resolver in
            let view = resolver.resolveSafe(AlbumsScreenViewInput.self)
            let interactor = resolver.resolveSafe(AlbumsScreenInteractorInput.self)
            let router = resolver.resolveSafe(AlbumsScreenRouterInput.self)
            return AlbumsScreenPresenter(view: view,
                                          interactor: interactor,
                                          router: router)
        }
        .implements(AlbumsScreenInteractorOutput.self)
        .implements(AlbumsScreenRouterOutput.self)
    }
    
    func registerRouter(in container: Container) {
        container.register(AlbumsScreenRouterInput.self) { resolver in
            let output = resolver.resolveSafe(AlbumsScreenRouterOutput.self)
            return AlbumsScreenRouter(output: output)
        }
    }
}
