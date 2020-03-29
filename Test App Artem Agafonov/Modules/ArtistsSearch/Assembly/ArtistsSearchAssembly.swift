//
//  ArtistsSearchAssembly.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 14.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import Swinject

final class ArtistsSearchAssembly {
    typealias View = ArtistsSearchViewController
    typealias Interactor = ArtistsSearchInteractor
    typealias Presenter = ArtistsSearchPresenter
    typealias Router = ArtistsSearchRouter
}

// MARK: - Assembly
extension ArtistsSearchAssembly: Assembly {
    func assemble(container: Container) {
        registerView(in: container)
        registerInteractor(in: container)
        registerPresenter(in: container)
        registerRouter(in: container)
        registerArtistCellModelFactory(in: container)
        registerDataSource(in: container)
    }
}

// MARK: - Registrations
private extension ArtistsSearchAssembly {
    func registerView(in container: Container) {
        container.register(ArtistsSearchViewInput.self) { _ in
            View()
        }
        .initCompleted { resolver, object in
            guard let viewController = object as? View else {
                fatalError("View has unexpected type: \(String(describing: object))")
            }
            viewController.output = resolver.resolveSafe(ArtistsSearchViewOutput.self)
        }
    }
    
    func registerInteractor(in container: Container) {
        container.register(ArtistsSearchInteractorInput.self) { resolver in
            let artistsSearchService = resolver.resolveSafe(ArtistsSearchService.self)
            return Interactor(artistsSearchService: artistsSearchService)
        }
        .initCompleted { resolver, object in
            guard let interactor = object as? Interactor else {
                fatalError("Interactor has unexpected type: \(String(describing: object))")
            }
            interactor.output = resolver.resolveSafe(ArtistsSearchInteractorOutput.self)
        }
    }
    
    func registerPresenter(in container: Container) {
        container.register(ArtistsSearchViewOutput.self) { resolver in
            let dataSource = resolver.resolveSafe(ArtistsSearchDataSource.self)
            return Presenter(dataSource: dataSource)
        }
        .implements(ArtistsSearchInteractorOutput.self)
        .implements(ArtistsSearchRouterOutput.self)
        .initCompleted { resolver, object in
            guard let presenter = object as? Presenter else {
                fatalError("Presenter has unexpected type: \(String(describing: object))")
            }
            presenter.view = resolver.resolveSafe(ArtistsSearchViewInput.self)
            presenter.interactor = resolver.resolveSafe(ArtistsSearchInteractorInput.self)
            presenter.router = resolver.resolveSafe(ArtistsSearchRouterInput.self)
        }
    }
    
    func registerRouter(in container: Container) {
        container.register(ArtistsSearchRouterInput.self) { resolver in
            let viewDispatcher = resolver.resolveSafe(ViewDispatcher.self)
            return Router(viewDispatcher: viewDispatcher)
        }
        .initCompleted { resolver, object in
            guard let router = object as? Router else {
                fatalError("Router has unexpected type: \(String(describing: object))")
            }
            router.output = resolver.resolveSafe(ArtistsSearchRouterOutput.self)
        }
    }
    
    func registerArtistCellModelFactory(in container: Container) {
        container.register(ArtistCellModelFactory.self) { _ in
            ArtistCellModelFactoryBase()
        }
    }
    
    func registerDataSource(in container: Container) {
        container.register(ArtistsSearchDataSource.self) { resolver in
            let viewModelFactory = resolver.resolveSafe(ArtistCellModelFactory.self)
            return ArtistsSearchDataSource(viewModelFactory: viewModelFactory)
        }
    }
}
