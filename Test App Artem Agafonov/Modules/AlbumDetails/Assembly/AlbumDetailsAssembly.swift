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
    typealias Configuration = AlbumDetailsConfiguration
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
        var lastConfiguration: Configuration?
        container.register(AlbumDetailsViewInput.self) { (_, configuration: Configuration) in
            lastConfiguration = configuration
            return View()
        }
        .initCompleted { resolver, object in
            guard let viewController = object as? View else {
                fatalError("View has unexpected type: \(String(describing: object))")
            }
            guard let configuration = lastConfiguration else {
                fatalError("Configuration is required")
            }
            viewController.output = resolver.resolveSafe(AlbumDetailsViewOutput.self,
                                                         argument: configuration)
        }
    }
    
    func registerInteractor(in container: Container) {
        var lastConfiguration: Configuration?
        container.register(AlbumDetailsInteractorInput.self) { (resolver, configuration: Configuration) in
            lastConfiguration = configuration
            let viewContextProvider = resolver.resolveSafe(PSViewContextProvider.self)
            return Interactor(viewContextProvider: viewContextProvider)
        }
        .initCompleted { resolver, object in
            guard let interactor = object as? Interactor else {
                fatalError("Interactor has unexpected type: \(String(describing: object))")
            }
            guard let configuration = lastConfiguration else {
                fatalError("Configuration is required")
            }
            interactor.output = resolver.resolveSafe(AlbumDetailsInteractorOutput.self,
                                                     argument: configuration)
        }
    }
    
    func registerPresenter(in container: Container) {
        var lastConfiguration: Configuration?
        container.register(AlbumDetailsViewOutput.self) { (_, configuration: Configuration) in
            lastConfiguration = configuration
            return Presenter(configuration: configuration)
        }
        .implements(AlbumDetailsInteractorOutput.self)
        .initCompleted { resolver, object in
            guard let presenter = object as? Presenter else {
                fatalError("Presenter has unexpected type: \(String(describing: object))")
            }
            guard let configuration = lastConfiguration else {
                fatalError("Configuration is required")
            }
            presenter.interactor = resolver.resolveSafe(AlbumDetailsInteractorInput.self,
                                                        argument: configuration)
            presenter.router = resolver.resolveSafe(AlbumDetailsRouterInput.self)
            presenter.view = resolver.resolveSafe(AlbumDetailsViewInput.self,
                                                  argument: configuration)
        }
    }
    
    func registerRouter(in container: Container) {
        container.register(AlbumDetailsRouterInput.self) { resolver in
            let viewDispatcher = resolver.resolveSafe(ViewDispatcher.self)
            return Router(viewDispatcher: viewDispatcher)
        }
    }
}
