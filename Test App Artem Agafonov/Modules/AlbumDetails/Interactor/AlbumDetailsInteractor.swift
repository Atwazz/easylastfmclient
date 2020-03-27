//
//  AlbumDetailsInteractor.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 14.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

final class AlbumDetailsInteractor {
    // MARK: - Public instance properties
    weak var output: AlbumDetailsInteractorOutput?
    
    // MARK: - Private insatnce properties
    private let viewContextProvider: PSViewContextProvider
    
    // MARK: - Init
    init(viewContextProvider: PSViewContextProvider) {
        self.viewContextProvider = viewContextProvider
    }
}

// MARK: - AlbumDetailsInteractorInput
extension AlbumDetailsInteractor: AlbumDetailsInteractorInput {
    func obtainAlbum(with id: PSObjectID) -> AlbumEntity? {
        viewContextProvider.viewContext.entity(with: id, of: AlbumEntity.self)
    }
}
