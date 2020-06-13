//
//  EntryPointFactory.swift
//  Easy Last FM Client
//
//  Created by Artem Agafonov on 14.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import Swinject

final class EntryPointFactory {
    // MARK: - Private instance properties
    private lazy var assembler: Assembler = {
        Assembler([EntryPointAssembly()], parent: servicesAssembler)
    }()
}

// MARK: - Public
extension EntryPointFactory {
    var router: EntryPointRouter {
        assembler.synchronizedResolveSafe(EntryPointRouter.self)
    }
    
    var window: UIWindow {
        assembler.synchronizedResolveSafe(UIWindow.self)
    }
}

// MARK: - Private
private extension EntryPointFactory {
    var servicesAssembler: Assembler {
        ServicesAssemblerProvider.instance.assembler
    }
}
