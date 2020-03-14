//
//  ArtistsSearchRouter.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 14.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

final class ArtistsSearchRouter {
    // MARK: - Private instance properties
    private weak var output: ArtistsSearchRouterOutput?
    
    // MARK: - Init
    init(output: ArtistsSearchRouterOutput) {
        self.output = output
    }
}

// MARK: - ArtistsSearchRouterIMput
extension ArtistsSearchRouter: ArtistsSearchRouterInput {
    
}
