//
//  MainScreenAssembly.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 14.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import Swinject

final class MainScreenAssembly {
    typealias View = MainScreenViewController
    typealias Interactor = MainScreenInteractor
    typealias Presenter = MainScreenPresenter
    typealias Router = MainScreenRouter
    typealias LayoutDelegate = CollectionViewDelegateFlowLayout
    
    // MARK: - Private static properties
    private static let layoutDelegateName = "MainScreenLayoutDelegate"
}

// MARK: - Assembly
extension MainScreenAssembly: Assembly {
    func assemble(container: Container) {
        registerView(in: container)
        registerInteractor(in: container)
        registerPresenter(in: container)
        registerRouter(in: container)
        registerCollectionViewCellModelFactory(in: container)
        registerCollectionViewDataSource(in: container)
        registerCollectionViewLayoutDelegate(in: container)
    }
}

// MARK: - Registrations
private extension MainScreenAssembly {
    func registerView(in container: Container) {
        container.register(MainScreenViewInput.self) { resolver in
            let layoutDelegate = resolver.resolveSafe(LayoutDelegate.self, name: Self.layoutDelegateName)
            return View(layoutDelegate: layoutDelegate)
        }
        .initCompleted { resolver, object in
            guard let viewController = object as? View else {
                fatalError("View has unexpected type: \(String(describing: object))")
            }
            viewController.output = resolver.resolveSafe(MainScreenViewOutput.self)
        }
    }
    
    func registerInteractor(in container: Container) {
        container.register(MainScreenInteractorInput.self) { resolver in
            let viewContextProvider = resolver.resolveSafe(PSViewContextProvider.self)
            return Interactor(viewContextProvider: viewContextProvider)
        }
    }
    
    func registerPresenter(in container: Container) {
        container.register(MainScreenViewOutput.self) { resolver in
            let storageStateEmitter = resolver.resolveSafe(PersistentStorageStateEmitter.self)
            let dataSource = resolver.resolveSafe(MainScreenCollectionViewDataSource.self)
            return Presenter(storageStateEmitter: storageStateEmitter,
                             dataSource: dataSource)
        }
        .initCompleted { resolver, object in
            guard let presenter = object as? Presenter else {
                fatalError("Presenter has unexpected type: \(String(describing: object))")
            }
            presenter.view = resolver.resolveSafe(MainScreenViewInput.self)
            presenter.interactor = resolver.resolveSafe(MainScreenInteractorInput.self)
            presenter.router = resolver.resolveSafe(MainScreenRouterInput.self)
        }
    }
    
    func registerRouter(in container: Container) {
        container.register(MainScreenRouterInput.self) { resolver in
            let viewDispatcher = resolver.resolveSafe(ViewDispatcher.self)
            let searchScreenFactory = resolver.resolveSafe(ArtistsSearchFactory.self)
            let albumDetailsScreenFactory = resolver.resolveSafe(AlbumDetailsFactory.self)
            return Router(viewDispatcher: viewDispatcher,
                          searchScreenFactory: searchScreenFactory,
                          albumDetailsScreenFactory: albumDetailsScreenFactory)
        }
    }
    
    func registerCollectionViewCellModelFactory(in container: Container) {
        container.register(AlbumCollectionViewModelFactory.self) { _ in
            AlbumCollectionViewModelFactoryBase()
        }
    }
    
    func registerCollectionViewDataSource(in container: Container) {
        container.register(MainScreenCollectionViewDataSource.self) { resolver in
            let viewModelFactory = resolver.resolveSafe(AlbumCollectionViewModelFactory.self)
            return MainScreenCollectionViewDataSource(viewModelFactory: viewModelFactory)
        }
    }
    
    func registerCollectionViewLayoutDelegate(in container: Container) {
        container.register(LayoutDelegate.self, name: Self.layoutDelegateName) { _ in
            AlbumsCollectionViewDelegateFlowLayout()
        }
    }
}
