//
//  TrackViewModelFactory.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 28.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

protocol TrackViewModelFactory {
    func vieModel(entity: TrackEntity) -> TrackViewModel
    func viewModel(track: Track) -> TrackViewModel
}
