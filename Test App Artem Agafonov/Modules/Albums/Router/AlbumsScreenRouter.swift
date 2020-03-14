//
//  AlbumsScreenRouter.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 14.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

final class AlbumsScreenRouter {
    // MARK: - Public instance properties
    weak var output: AlbumsScreenRouterOutput?
    
    // MARK: - Private instance properties
    private let viewDispatcher: ViewDispatcher
    
    // MARK: - Init
    init(viewDispatcher: ViewDispatcher) {
        self.viewDispatcher = viewDispatcher
    }
}

// MARK: - AlbumsScreenRouterIMput
extension AlbumsScreenRouter: AlbumsScreenRouterInput {
    
}
