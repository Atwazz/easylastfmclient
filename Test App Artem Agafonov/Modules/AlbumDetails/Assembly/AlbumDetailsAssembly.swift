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
    typealias LayoutDelegate = CollectionViewDelegateFlowLayout
    
    // MARK: - Private static properties
    private static let tagsLayoutDelegate = "AlbumDetailsTagsLayoutDelegate"
}

// MARK: - Assembly
extension AlbumDetailsAssembly: Assembly {
    func assemble(container: Container) {
        registerView(in: container)
        registerInteractor(in: container)
        registerPresenter(in: container)
        registerRouter(in: container)
        registerAlbumTagsDataSource(in: container)
        registerAlbumDetailsViewModelFactory(in: container)
        registerArtistViewModelFactory(in: container)
        registerTagViewModelFactory(in: container)
        registerTrackViewModelFactory(in: container)
        registerTagsCollectionViewLayoutDelegate(in: container)
    }
}

// MARK: - Registrations
private extension AlbumDetailsAssembly {
    func registerView(in container: Container) {
        var lastConfiguration: Configuration?
        container.register(AlbumDetailsViewInput.self) { (resolver, configuration: Configuration) in
            lastConfiguration = configuration
            let tagsFlowLayout = resolver.resolveSafe(LayoutDelegate.self, name: Self.tagsLayoutDelegate)
            return View(tagsFlowLayout: tagsFlowLayout)
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
            let backgroundTaskInvoker = resolver.resolveSafe(PSBackgroundTaskInvoker.self)
            let albumInfoLoadService = resolver.resolveSafe(AlbumInfoLoadService.self)
            let albumsSaver = resolver.resolveSafe(AlbumsSaver.self)
            return Interactor(viewContextProvider: viewContextProvider,
                              backgroundTaskInvoker: backgroundTaskInvoker,
                              albumInfoLoadService: albumInfoLoadService,
                              albumsSaver: albumsSaver)
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
        container.register(AlbumDetailsViewOutput.self) { (resolver, configuration: Configuration) in
            lastConfiguration = configuration
            let viewModelFactory = resolver.resolveSafe(AlbumDetailsViewModelFactory.self)
            let tagsDataSource = resolver.resolveSafe(AlbumTagsDataSource.self)
            let urlHandler = resolver.resolveSafe(URLHandler.self)
            return Presenter(configuration: configuration,
                             viewModelFactory: viewModelFactory,
                             tagsDataSource: tagsDataSource,
                             urlhandler: urlHandler)
        }
        .implements(AlbumDetailsInteractorOutput.self)
        .implements(AlbumDetailsRouterOutput.self)
        .initCompleted { resolver, object in
            guard let presenter = object as? Presenter else {
                fatalError("Presenter has unexpected type: \(String(describing: object))")
            }
            guard let configuration = lastConfiguration else {
                fatalError("Configuration is required")
            }
            presenter.interactor = resolver.resolveSafe(AlbumDetailsInteractorInput.self,
                                                        argument: configuration)
            presenter.router = resolver.resolveSafe(AlbumDetailsRouterInput.self,
                                                    argument: configuration)
            presenter.view = resolver.resolveSafe(AlbumDetailsViewInput.self,
                                                  argument: configuration)
        }
    }
    
    func registerRouter(in container: Container) {
        var lastConfiguration: Configuration?
        container.register(AlbumDetailsRouterInput.self) { (resolver, configuration: Configuration) in
            lastConfiguration = configuration
            let viewDispatcher = resolver.resolveSafe(ViewDispatcher.self)
            return Router(viewDispatcher: viewDispatcher)
        }
        .initCompleted { resolver, object in
            guard let router = object as? Router else {
                fatalError("Router has unexpected type: \(String(describing: object))")
            }
            guard let configuration = lastConfiguration else {
                fatalError("Configuration is required")
            }
            router.output = resolver.resolveSafe(AlbumDetailsRouterOutput.self,
                                                 argument: configuration)
        }
    }
    
    func registerAlbumTagsDataSource(in container: Container) {
        container.register(AlbumTagsDataSource.self) { _ in
            AlbumTagsDataSource()
        }
        .implements(AlbumTagNameProvider.self)
        .inObjectScope(.weak)
    }
    
    func registerAlbumDetailsViewModelFactory(in container: Container) {
        container.register(AlbumDetailsViewModelFactory.self) { resolver in
            let artistViewModelFactory = resolver.resolveSafe(ArtistViewModelFactory.self)
            let tagViewModelFactory = resolver.resolveSafe(TagViewModelFactory.self)
            let trackViewModelFactory = resolver.resolveSafe(TrackViewModelFactory.self)
            return AlbumDetailsViewModelFactoryBase(artistViewModelFactory: artistViewModelFactory,
                                                    tagViewModelFactory: tagViewModelFactory,
                                                    trackViewModelFactory: trackViewModelFactory)
        }
    }
    
    func registerArtistViewModelFactory(in container: Container) {
        container.register(ArtistViewModelFactory.self) { _ in
            ArtistViewModelFactoryBase()
        }
    }
    
    func registerTagViewModelFactory(in container: Container) {
        container.register(TagViewModelFactory.self) { _ in
            TagViewModelFactoryBase()
        }
    }
    
    func registerTrackViewModelFactory(in container: Container) {
        container.register(TrackViewModelFactory.self) { _ in
            TrackViewModelFactoryBase()
        }
    }
    
    func registerTagsCollectionViewLayoutDelegate(in container: Container) {
        container.register(LayoutDelegate.self, name: Self.tagsLayoutDelegate) { resolver in
            let tagNameProvider = resolver.resolveSafe(AlbumTagNameProvider.self)
            return TagsCollectionViewDelegateFlowLayout(nameProvider: tagNameProvider)
        }
    }
}
