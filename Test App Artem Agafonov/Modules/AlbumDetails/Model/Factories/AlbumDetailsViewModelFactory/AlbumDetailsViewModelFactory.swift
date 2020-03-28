//
//  AlbumDetailsViewModelFactory.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 28.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

protocol AlbumDetailsViewModelFactory {
    typealias ViewModel = AlbumDetailsViewModel
    
    func viewModel(entity: AlbumEntity) -> ViewModel
    func viewModel(albumExtendedInfo: AlbumExtendedInfo, artist: Artist) -> ViewModel
}
