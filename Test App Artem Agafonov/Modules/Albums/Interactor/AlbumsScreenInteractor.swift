//
//  AlbumsScreenInteractor.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 14.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

final class AlbumsScreenInteractor {
    // MARK: - Private instance properties
    private weak var output: AlbumsScreenInteractorOutput?
    
    // MARK: - Init
    init(output: AlbumsScreenInteractorOutput) {
        self.output = output
    }
}

// MARK: - AlbumsScreenInteractorInput
extension AlbumsScreenInteractor: AlbumsScreenInteractorInput {
    
}
