//
//  ArtistsSearchPresenter.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 14.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

final class ArtistsSearchPresenter {
    // MARK: - Public instance properties
    @DelayedImmutable var view: ArtistsSearchViewInput
    @DelayedImmutable var interactor: ArtistsSearchInteractorInput
    @DelayedImmutable var router: ArtistsSearchRouterInput
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
