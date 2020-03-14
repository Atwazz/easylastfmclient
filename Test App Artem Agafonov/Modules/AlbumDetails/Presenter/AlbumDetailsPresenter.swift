//
//  AlbumDetailsPresenter.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 14.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

final class AlbumDetailsPresenter {
    // MARK: - Public instance properties
    @DelayedImmutable var view: AlbumDetailsViewInput
    @DelayedImmutable var interactor: AlbumDetailsInteractorInput
    @DelayedImmutable var router: AlbumDetailsRouterInput
}

// MARK: - AlbumDetailsViewOutput
extension AlbumDetailsPresenter: AlbumDetailsViewOutput {
    
}

// MARK: - AlbumDetailsInteractorOutput
extension AlbumDetailsPresenter: AlbumDetailsInteractorOutput {
    
}

// MARK: - AlbumDetailsRouterOutput
extension AlbumDetailsPresenter: AlbumDetailsRouterOutput {
    
}