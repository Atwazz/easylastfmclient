//
//  ArtistsSearchInteractor.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 14.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

final class ArtistsSearchInteractor {
    // MARK: - Private instance properties
    private weak var output: ArtistsSearchInteractorOutput?
    
    // MARK: - Init
    init(output: ArtistsSearchInteractorOutput) {
        self.output = output
    }
}

// MARK: - ArtistsSearchInteractorInput
extension ArtistsSearchInteractor: ArtistsSearchInteractorInput {
    
}
