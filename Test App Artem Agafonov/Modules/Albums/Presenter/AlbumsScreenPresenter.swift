//
//  AlbumsScreenPresenter.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 14.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

final class AlbumsScreenPresenter {
    // MARK: - Private instance properties
    private let view: AlbumsScreenViewInput
    private let interactor: AlbumsScreenInteractorInput
    private let router: AlbumsScreenRouterInput
    
    // MARK: - Init
    init(view: AlbumsScreenViewInput,
         interactor: AlbumsScreenInteractorInput,
         router: AlbumsScreenRouterInput) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

// MARK: - AlbumsScreenViewOutput
extension AlbumsScreenPresenter: AlbumsScreenViewOutput {
    
}

// MARK: - AlbumsScreenInteractorOutput
extension AlbumsScreenPresenter: AlbumsScreenInteractorOutput {
    
}

// MARK: - AlbumsScreenRouterOutput
extension AlbumsScreenPresenter: AlbumsScreenRouterOutput {
    
}
