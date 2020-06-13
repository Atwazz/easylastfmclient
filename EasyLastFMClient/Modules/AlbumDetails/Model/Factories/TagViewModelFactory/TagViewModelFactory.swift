//
//  TagViewModelFactory.swift
//  Easy Last FM Client
//
//  Created by Artem Agafonov on 28.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

protocol TagViewModelFactory {
    func viewModel(entity: TagEntity) -> TagViewModel
    func viewModel(tag: Tag) -> TagViewModel
}
