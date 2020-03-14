//
//  AlbumsScreenRouter.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 14.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

final class AlbumsScreenRouter {
    // MARK: - Private instance properties
    private weak var output: AlbumsScreenRouterOutput?
    
    // MARK: - Init
    init(output: AlbumsScreenRouterOutput) {
        self.output = output
    }
}

// MARK: - AlbumsScreenRouterIMput
extension AlbumsScreenRouter: AlbumsScreenRouterInput {
    
}
