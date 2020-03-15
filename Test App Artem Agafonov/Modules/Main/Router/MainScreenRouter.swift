//
//  MainScreenRouter.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 14.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

final class MainScreenRouter {
    // MARK: - Public instance properties
    weak var output: MainScreenRouterOutput?
    
    // MARK: - Private instance properties
    private let viewDispatcher: ViewDispatcher
    private let searchScreenFactory: ScreenFactory
    
    // MARK: - Init
    init(viewDispatcher: ViewDispatcher,
         searchScreenFactory: ScreenFactory) {
        self.viewDispatcher = viewDispatcher
        self.searchScreenFactory = searchScreenFactory
    }
}

// MARK: - MainScreenRouterIMput
extension MainScreenRouter: MainScreenRouterInput {
    func showSearchScreen() {
        viewDispatcher.push(searchScreenFactory.viewController)
    }
}
