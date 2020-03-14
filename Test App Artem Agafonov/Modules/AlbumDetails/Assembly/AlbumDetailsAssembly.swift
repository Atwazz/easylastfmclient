//
//  AlbumDetailsAssembly.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 14.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import Swinject

final class AlbumDetailsAssembly { }

// MARK: - Assembly
extension AlbumDetailsAssembly: Assembly {
    func assemble(container: Container) {
        registerView(in: container)
        registerInteractor(in: container)
        registerPresenter(in: container)
        registerRouter(in: container)
    }
}

// MARK: - Registrations
private extension AlbumDetailsAssembly {
    func registerView(in container: Container) {
        container.register(AlbumDetailsViewInput.self) { resolver in
            let viewOutput = resolver.resolveSafe(AlbumDetailsViewOutput.self)
            return AlbumDetailsViewController(output: viewOutput)
        }
    }
    
    func registerInteractor(in container: Container) {
        container.register(AlbumDetailsInteractorInput.self) { resolver in
            let output = resolver.resolveSafe(AlbumDetailsInteractorOutput.self)
            return AlbumDetailsInteractor(output: output)
        }
    }
    
    func registerPresenter(in container: Container) {
        container.register(AlbumDetailsViewOutput.self) { resolver in
            let view = resolver.resolveSafe(AlbumDetailsViewInput.self)
            let interactor = resolver.resolveSafe(AlbumDetailsInteractorInput.self)
            let router = resolver.resolveSafe(AlbumDetailsRouterInput.self)
            return AlbumDetailsPresenter(view: view,
                                          interactor: interactor,
                                          router: router)
        }
        .implements(AlbumDetailsInteractorOutput.self)
        .implements(AlbumDetailsRouterOutput.self)
    }
    
    func registerRouter(in container: Container) {
        container.register(AlbumDetailsRouterInput.self) { resolver in
            let output = resolver.resolveSafe(AlbumDetailsRouterOutput.self)
            return AlbumDetailsRouter(output: output)
        }
    }
}
