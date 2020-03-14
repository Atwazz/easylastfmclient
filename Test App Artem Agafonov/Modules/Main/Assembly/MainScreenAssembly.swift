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
}

// MARK: - Assembly
extension MainScreenAssembly: Assembly {
    func assemble(container: Container) {
        registerView(in: container)
        registerInteractor(in: container)
        registerPresenter(in: container)
        registerRouter(in: container)
    }
}

// MARK: - Registrations
private extension MainScreenAssembly {
    func registerView(in container: Container) {
        container.register(MainScreenViewInput.self) { _ in
            View()
        }
        .initCompleted { resolver, object in
            guard let viewController = object as? View else {
                fatalError("View has unexpected type: \(String(describing: object))")
            }
            viewController.output = resolver.resolveSafe(MainScreenViewOutput.self)
        }
    }
    
    func registerInteractor(in container: Container) {
        container.register(MainScreenInteractorInput.self) { _ in
            Interactor()
        }
        .initCompleted { resolver, object in
            guard let interactor = object as? Interactor else {
                fatalError("Interactor has unexpected type: \(String(describing: object))")
            }
            interactor.output = resolver.resolveSafe(MainScreenInteractorOutput.self)
        }
    }
    
    func registerPresenter(in container: Container) {
        container.register(MainScreenViewOutput.self) { _ in
            Presenter()
        }
        .implements(MainScreenInteractorOutput.self)
        .implements(MainScreenRouterOutput.self)
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
            return Router(viewDispatcher: viewDispatcher)
        }
        .initCompleted { resolver, object in
            guard let router = object as? Router else {
                fatalError("Router has unexpected type: \(String(describing: object))")
            }
            router.output = resolver.resolveSafe(MainScreenRouterOutput.self)
        }
    }
}
