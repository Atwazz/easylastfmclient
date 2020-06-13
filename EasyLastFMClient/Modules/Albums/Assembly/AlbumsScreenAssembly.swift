//
//  AlbumsScreenAssembly.swift
//  Easy Last FM Client
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
    typealias Configuration = AlbumsScreenConfiguration
}

// MARK: - Assembly
extension AlbumsScreenAssembly: Assembly {
    func assemble(container: Container) {
        registerView(in: container)
        registerInteractor(in: container)
        registerPresenter(in: container)
        registerRouter(in: container)
        registerAlbumModelFactory(in: container)
        registerAlbumCellModelFactory(in: container)
        registerDataSource(in: container)
    }
}

// MARK: - Registrations
private extension AlbumsScreenAssembly {
    func registerView(in container: Container) {
        var lastConfiguration: Configuration?
        container.register(AlbumsScreenViewInput.self) { (_, configuration: Configuration) in
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
            viewController.output = resolver.resolveSafe(AlbumsScreenViewOutput.self,
                                                         argument: configuration)
        }
    }
    
    func registerInteractor(in container: Container) {
        var lastConfiguration: Configuration?
        container.register(AlbumsScreenInteractorInput.self) { (resolver, configuration: Configuration) in
            lastConfiguration = configuration
            let albumsLoadService = resolver.resolveSafe(ArtistAlbumsLoadService.self)
            let backgroundTaskInvoker = resolver.resolveSafe(PSBackgroundTaskInvoker.self)
            let artistFetcher = resolver.resolveSafe(ArtistEntityFetcher.self)
            return Interactor(albumsLoadService: albumsLoadService,
                              artistFetcher: artistFetcher,
                              backgroundTaskInvoker: backgroundTaskInvoker)
        }
        .initCompleted { resolver, object in
            guard let interactor = object as? Interactor else {
                fatalError("Interactor has unexpected type: \(String(describing: object))")
            }
            guard let configuration = lastConfiguration else {
                fatalError("Configuration is required")
            }
            interactor.output = resolver.resolveSafe(AlbumsScreenInteractorOutput.self,
                                                     argument: configuration)
        }
    }
    
    func registerPresenter(in container: Container) {
        var lastConfiguration: Configuration?
        container.register(AlbumsScreenViewOutput.self) { (resolver, configuration: Configuration) in
            lastConfiguration = configuration
            let dataSource = resolver.resolveSafe(AlbumsScreenDataSource.self)
            return Presenter(configuration: configuration,
                             dataSource: dataSource)
        }
        .implements(AlbumsScreenInteractorOutput.self)
        .implements(AlbumsScreenRouterOutput.self)
        .initCompleted { resolver, object in
            guard let presenter = object as? Presenter else {
                fatalError("Presenter has unexpected type: \(String(describing: object))")
            }
            guard let configuration = lastConfiguration else {
                fatalError("Configuration is required")
            }
            presenter.view = resolver.resolveSafe(AlbumsScreenViewInput.self,
                                                  argument: configuration)
            presenter.interactor = resolver.resolveSafe(AlbumsScreenInteractorInput.self,
                                                        argument: configuration)
            presenter.router = resolver.resolveSafe(AlbumsScreenRouterInput.self,
                                                    argument: configuration)
        }
    }
    
    func registerRouter(in container: Container) {
        var lastConfiguration: Configuration?
        container.register(AlbumsScreenRouterInput.self) { (resolver, configuration: Configuration) in
            lastConfiguration = configuration
            let viewDispatcher = resolver.resolveSafe(ViewDispatcher.self)
            let albumDetailsFactory = resolver.resolveSafe(AlbumDetailsFactory.self)
            return Router(viewDispatcher: viewDispatcher,
                          albumDetailsFactory: albumDetailsFactory)
        }
        .initCompleted { resolver, object in
            guard let router = object as? Router else {
                fatalError("Router has unexpected type: \(String(describing: object))")
            }
            guard let configuration = lastConfiguration else {
                fatalError("Configuration is required")
            }
            router.output = resolver.resolveSafe(AlbumsScreenRouterOutput.self,
                                                 argument: configuration)
        }
    }
    
    func registerAlbumCellModelFactory(in container: Container) {
        container.register(AlbumCellModelFactory.self) { _ in
            AlbumCellModelFactoryBase()
        }
    }
    
    func registerAlbumModelFactory(in container: Container) {
        container.register(AlbumModelFactory.self) { resolver in
            let albumFetcher = resolver.resolveSafe(AlbumEntityFetcher.self)
            let backgroundTaskInvoker = resolver.resolveSafe(PSBackgroundTaskInvoker.self)
            return AlbumModelFactoryBase(albumFetcher: albumFetcher,
                                         backgroundTaskInvoker: backgroundTaskInvoker)
        }
    }
    
    func registerDataSource(in container: Container) {
        container.register(AlbumsScreenDataSource.self) { resolver in
            let viewModelFactory = resolver.resolveSafe(AlbumCellModelFactory.self)
            let modelFactory = resolver.resolveSafe(AlbumModelFactory.self)
            return AlbumsScreenDataSource(viewModelFactory: viewModelFactory,
                                          modelFactory: modelFactory)
        }
    }
}
