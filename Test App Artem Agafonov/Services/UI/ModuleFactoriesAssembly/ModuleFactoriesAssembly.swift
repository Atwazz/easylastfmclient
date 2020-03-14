//
//  ModuleFactoriesAssembly.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 14.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import Swinject

final class ModuleFactoriesAssembly: Assembly {
    // MARK: - Assembly
    func assemble(container: Container) {
        registerMainScreenFactory(in: container)
    }
}

// MARK: - Private - Register
private extension ModuleFactoriesAssembly {
    func registerMainScreenFactory(in container: Container) {
        container.register(MainScreenFactory.self) { _ in
            MainScreenFactory(parentAssembler: Self.servicesAssembler)
        }
    }
}

// MARK: - Private
private extension ModuleFactoriesAssembly {
    static var servicesAssembler: Assembler {
        ServicesAssemblerProvider.instance.assembler
    }
}
