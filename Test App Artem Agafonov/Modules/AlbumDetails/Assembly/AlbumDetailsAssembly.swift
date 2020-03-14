//
//  AlbumDetailsAssembly.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 14.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import Swinject

final class AlbumDetailsAssembly {
    typealias View = AlbumDetailsViewController
    typealias Interactor = AlbumDetailsInteractor
    typealias Presenter = AlbumDetailsPresenter
    typealias Router = AlbumDetailsRouter
}

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
        container.register(AlbumDetailsViewInput.self) { _ in
            View()
        }
        .initCompleted { resolver, object in
            guard let viewController = object as? View else {
                fatalError("View has unexpected type: \(String(describing: object))")
            }
            viewController.output = resolver.resolveSafe(AlbumDetailsViewOutput.self)
        }
    }
    
    func registerInteractor(in container: Container) {
        container.register(AlbumDetailsInteractorInput.self) { _ in
            Interactor()
        }
        .initCompleted { resolver, object in
            guard let interactor = object as? Interactor else {
                fatalError("Interactor has unexpected type: \(String(describing: object))")
            }
            interactor.output = resolver.resolveSafe(AlbumDetailsInteractorOutput.self)
        }
    }
    
    func registerPresenter(in container: Container) {
        container.register(AlbumDetailsViewOutput.self) { _ in
            Presenter()
        }
        .implements(AlbumDetailsInteractorOutput.self)
        .implements(AlbumDetailsRouterOutput.self)
        .initCompleted { resolver, object in
            guard let presenter = object as? Presenter else {
                fatalError("Presenter has unexpected type: \(String(describing: object))")
            }
            presenter.view = resolver.resolveSafe(AlbumDetailsViewInput.self)
            presenter.interactor = resolver.resolveSafe(AlbumDetailsInteractorInput.self)
            presenter.router = resolver.resolveSafe(AlbumDetailsRouterInput.self)
        }
    }
    
    func registerRouter(in container: Container) {
        container.register(AlbumDetailsRouterInput.self) { resolver in
            let viewDispatcher = resolver.resolveSafe(ViewDispatcher.self)
            return Router(viewDispatcher: viewDispatcher)
        }
        .initCompleted { resolver, object in
            guard let router = object as? Router else {
                fatalError("Router has unexpected type: \(String(describing: object))")
            }
            router.output = resolver.resolveSafe(AlbumDetailsRouterOutput.self)
        }
    }
}
