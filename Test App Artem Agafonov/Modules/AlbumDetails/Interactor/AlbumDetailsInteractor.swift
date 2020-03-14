//
//  AlbumDetailsInteractor.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 14.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

final class AlbumDetailsInteractor {
    // MARK: - Private instance properties
    private weak var output: AlbumDetailsInteractorOutput?
    
    // MARK: - Init
    init(output: AlbumDetailsInteractorOutput) {
        self.output = output
    }
}

// MARK: - AlbumDetailsInteractorInput
extension AlbumDetailsInteractor: AlbumDetailsInteractorInput {
    
}
