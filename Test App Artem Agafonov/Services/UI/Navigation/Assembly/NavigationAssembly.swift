//
//  NavigationAssembly.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 14.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import Swinject

final class NavigationAssembly { }

// MARK: - Assembly
extension NavigationAssembly: Assembly {
    func assemble(container: Container) {
        registerViewDispatcher(in: container)
        registerWindow(in: container)
    }
}

// MARK: - Registrations
private extension NavigationAssembly {
    func registerViewDispatcher(in container: Container) {
        container.register(ViewDispatcher.self) { resolver in
            let window = resolver.resolveSafe(UIWindow.self)
            return ViewDispatcherBase(window: window)
        }
    }
    
    func registerWindow(in container: Container) {
        container.register(UIWindow.self) { resolver in
            let screenBounds = resolver.resolveSafe(ScreenSizeProvider.self).screenBounds
            return UIWindow(frame: screenBounds)
        }
        .inObjectScope(.weak)
    }
}
