//
//  AlbumsScreenPresenter.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 14.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

final class AlbumsScreenPresenter {
    // MARK: - Public instance properties
    @DelayedImmutable var view: AlbumsScreenViewInput
    @DelayedImmutable var interactor: AlbumsScreenInteractorInput
    @DelayedImmutable var router: AlbumsScreenRouterInput
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
