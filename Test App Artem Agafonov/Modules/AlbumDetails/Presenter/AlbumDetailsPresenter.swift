//
//  AlbumDetailsPresenter.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 14.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

final class AlbumDetailsPresenter {
    // MARK: - Private instance properties
    private let view: AlbumDetailsViewInput
    private let interactor: AlbumDetailsInteractorInput
    private let router: AlbumDetailsRouterInput
    
    // MARK: - Init
    init(view: AlbumDetailsViewInput,
         interactor: AlbumDetailsInteractorInput,
         router: AlbumDetailsRouterInput) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
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
