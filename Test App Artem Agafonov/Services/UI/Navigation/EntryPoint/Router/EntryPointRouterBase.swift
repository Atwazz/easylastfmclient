//
//  EntryPointRouterBase.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 14.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

final class EntryPointRouterBase {
    // MARK: - Private instance properties
    private let viewDispatcher: ViewDispatcher
    private let screenFactory: ScreenFactory
    
    // MARK: - Init
    init(viewDispatcher: ViewDispatcher,
         initialScreenFactory: ScreenFactory) {
        self.viewDispatcher = viewDispatcher
        screenFactory = initialScreenFactory
    }
}

// MARK: - EntryPointRouter
extension EntryPointRouterBase: EntryPointRouter {
    func showInitialScreen() {
        viewDispatcher.show(rootViewController: screenFactory.viewController)
    }
}
