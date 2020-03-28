//
//  AlbumCollectionViewModelFactory.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 22.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

protocol AlbumCollectionViewModelFactory {
    func model(for entity: AlbumEntity) -> AlbumCollectionViewModel
}
