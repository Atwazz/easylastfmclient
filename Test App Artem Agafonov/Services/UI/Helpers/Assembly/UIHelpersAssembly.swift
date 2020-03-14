//
//  UIHelpersAssembly.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 14.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import Swinject

final class UIHelpersAssembly {}

// MARK: - Assembly
extension UIHelpersAssembly: Assembly {
    func assemble(container: Container) {
        registerScreenProvider(in: container)
    }
}

// MARK: - Registrations
private extension UIHelpersAssembly {
    func registerScreenProvider(in container: Container) {
        container.register(ScreenSizeProvider.self) { _ in
            UIScreen.main
        }
    }
}
