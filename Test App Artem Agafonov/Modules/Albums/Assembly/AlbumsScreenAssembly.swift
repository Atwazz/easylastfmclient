//
//  AlbumsScreenAssembly.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 14.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import Swinject

final class AlbumsScreenAssembly {
    typealias View = AlbumsScreenViewController
    typealias Interactor = AlbumsScreenInteractor
    typealias Presenter = AlbumsScreenPresenter
    typealias Router = AlbumsScreenRouter
}

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
        container.register(AlbumsScreenViewInput.self) { _ in
            View()
        }
        .initCompleted { resolver, object in
            guard let viewController = object as? View else {
                fatalError("View has unexpected type: \(String(describing: object))")
            }
            viewController.output = resolver.resolveSafe(AlbumsScreenViewOutput.self)
        }
    }
    
    func registerInteractor(in container: Container) {
        container.register(AlbumsScreenInteractorInput.self) { _ in
            Interactor()
        }
        .initCompleted { resolver, object in
            guard let interactor = object as? Interactor else {
                fatalError("Interactor has unexpected type: \(String(describing: object))")
            }
            interactor.output = resolver.resolveSafe(AlbumsScreenInteractorOutput.self)
        }
    }
    
    func registerPresenter(in container: Container) {
        container.register(AlbumsScreenViewOutput.self) { _ in
            Presenter()
        }
        .implements(AlbumsScreenInteractorOutput.self)
        .implements(AlbumsScreenRouterOutput.self)
        .initCompleted { resolver, object in
            guard let presenter = object as? Presenter else {
                fatalError("Presenter has unexpected type: \(String(describing: object))")
            }
            presenter.view = resolver.resolveSafe(AlbumsScreenViewInput.self)
            presenter.interactor = resolver.resolveSafe(AlbumsScreenInteractorInput.self)
            presenter.router = resolver.resolveSafe(AlbumsScreenRouterInput.self)
        }
    }
    
    func registerRouter(in container: Container) {
        container.register(AlbumsScreenRouterInput.self) { resolver in
            let viewDispatcher = resolver.resolveSafe(ViewDispatcher.self)
            return Router(viewDispatcher: viewDispatcher)
        }
        .initCompleted { resolver, object in
            guard let router = object as? Router else {
                fatalError("Router has unexpected type: \(String(describing: object))")
            }
            router.output = resolver.resolveSafe(AlbumsScreenRouterOutput.self)
        }
    }
}
