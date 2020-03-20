//
//  ArtistsSearchRouter.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 14.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

final class ArtistsSearchRouter {
    // MARK: - Public instance properties
    weak var output: ArtistsSearchRouterOutput?
    
    // MARK: - Private instance properties
    private let viewDispatcher: ViewDispatcher
    
    // MARK: - Init
    init(viewDispatcher: ViewDispatcher) {
        self.viewDispatcher = viewDispatcher
    }
}

// MARK: - ArtistsSearchRouterIMput
extension ArtistsSearchRouter: ArtistsSearchRouterInput {
    func showAlert(error: Error) {
        
    }
}
