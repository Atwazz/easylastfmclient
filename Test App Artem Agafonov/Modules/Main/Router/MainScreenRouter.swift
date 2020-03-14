//
//  MainScreenRouter.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 14.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

final class MainScreenRouter {
    // MARK: - Private instance properties
    private weak var output: MainScreenRouterOutput?
    
    // MARK: - Init
    init(output: MainScreenRouterOutput) {
        self.output = output
    }
}

// MARK: - MainScreenRouterIMput
extension MainScreenRouter: MainScreenRouterInput {
    
}
