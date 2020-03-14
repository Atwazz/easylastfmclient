//
//  AlbumDetailsRouter.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 14.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

final class AlbumDetailsRouter {
    // MARK: - Private instance properties
    private weak var output: AlbumDetailsRouterOutput?
    
    // MARK: - Init
    init(output: AlbumDetailsRouterOutput) {
        self.output = output
    }
}

// MARK: - AlbumDetailsRouterIMput
extension AlbumDetailsRouter: AlbumDetailsRouterInput {
    
}
