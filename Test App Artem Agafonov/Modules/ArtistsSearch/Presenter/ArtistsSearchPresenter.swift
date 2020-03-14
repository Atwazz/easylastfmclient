//
//  ArtistsSearchPresenter.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 14.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

final class ArtistsSearchPresenter {
    // MARK: - Private instance properties
    private let view: ArtistsSearchViewInput
    private let interactor: ArtistsSearchInteractorInput
    private let router: ArtistsSearchRouterInput
    
    // MARK: - Init
    init(view: ArtistsSearchViewInput,
         interactor: ArtistsSearchInteractorInput,
         router: ArtistsSearchRouterInput) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

// MARK: - ArtistsSearchViewOutput
extension ArtistsSearchPresenter: ArtistsSearchViewOutput {
    
}

// MARK: - ArtistsSearchInteractorOutput
extension ArtistsSearchPresenter: ArtistsSearchInteractorOutput {
    
}

// MARK: - ArtistsSearchRouterOutput
extension ArtistsSearchPresenter: ArtistsSearchRouterOutput {
    
}
