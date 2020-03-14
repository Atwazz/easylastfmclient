//
//  MainScreenPresenter.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 14.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

final class MainScreenPresenter {
    // MARK: - Private instance properties
    private let view: MainScreenViewInput
    private let interactor: MainScreenInteractorInput
    private let router: MainScreenRouterInput
    
    // MARK: - Init
    init(view: MainScreenViewInput,
         interactor: MainScreenInteractorInput,
         router: MainScreenRouterInput) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
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
