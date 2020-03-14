//
//  MainScreenAssembly.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 14.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import Swinject

final class MainScreenAssembly { }

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
        container.register(MainScreenViewInput.self) { resolver in
            let viewOutput = resolver.resolveSafe(MainScreenViewOutput.self)
            return MainScreenViewController(output: viewOutput)
        }
    }
    
    func registerInteractor(in container: Container) {
        container.register(MainScreenInteractorInput.self) { resolver in
            let output = resolver.resolveSafe(MainScreenInteractorOutput.self)
            return MainScreenInteractor(output: output)
        }
    }
    
    func registerPresenter(in container: Container) {
        container.register(MainScreenViewOutput.self) { resolver in
            let view = resolver.resolveSafe(MainScreenViewInput.self)
            let interactor = resolver.resolveSafe(MainScreenInteractorInput.self)
            let router = resolver.resolveSafe(MainScreenRouterInput.self)
            return MainScreenPresenter(view: view,
                                          interactor: interactor,
                                          router: router)
        }
        .implements(MainScreenInteractorOutput.self)
        .implements(MainScreenRouterOutput.self)
    }
    
    func registerRouter(in container: Container) {
        container.register(MainScreenRouterInput.self) { resolver in
            let output = resolver.resolveSafe(MainScreenRouterOutput.self)
            return MainScreenRouter(output: output)
        }
    }
}
