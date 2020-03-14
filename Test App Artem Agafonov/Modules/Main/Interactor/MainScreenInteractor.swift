//
//  MainScreenInteractor.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 14.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

final class MainScreenInteractor {
    // MARK: - Private instance properties
    private weak var output: MainScreenInteractorOutput?
    
    // MARK: - Init
    init(output: MainScreenInteractorOutput) {
        self.output = output
    }
}

// MARK: - MainScreenInteractorInput
extension MainScreenInteractor: MainScreenInteractorInput {
    
}
