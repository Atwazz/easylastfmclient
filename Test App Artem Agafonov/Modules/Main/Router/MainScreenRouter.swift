//
//  MainScreenRouter.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 14.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import UIKit.UIAlertController

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
    func showAlertWithError(_ error: LocalizedError, completion: (() -> Void)?) {
        let alertController = UIAlertController(title: "Error",
                                                message: error.localizedDescription,
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        viewDispatcher.presentModal(alertController, completion: completion)
    }
    
    func showSearchScreen() {
        viewDispatcher.push(searchScreenFactory.viewController)
    }
}
