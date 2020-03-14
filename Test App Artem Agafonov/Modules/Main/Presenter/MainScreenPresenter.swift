//
//  MainScreenPresenter.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 14.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

final class MainScreenPresenter {
    // MARK: - Public instance properties
    @DelayedImmutable var view: MainScreenViewInput
    @DelayedImmutable var interactor: MainScreenInteractorInput
    @DelayedImmutable var router: MainScreenRouterInput
}

// MARK: - MainScreenViewOutput
extension MainScreenPresenter: MainScreenViewOutput {
    
}

// MARK: - MainScreenInteractorOutput
extension MainScreenPresenter: MainScreenInteractorOutput {
    
}

// MARK: - MainScreenRouterOutput
extension MainScreenPresenter: MainScreenRouterOutput {
    
}
