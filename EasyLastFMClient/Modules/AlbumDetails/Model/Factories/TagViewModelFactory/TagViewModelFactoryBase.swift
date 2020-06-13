//
//  TagViewModelFactoryBase.swift
//  Easy Last FM Client
//
//  Created by Artem Agafonov on 28.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

struct TagViewModelFactoryBase { }

// MARK: - TagViewModelFactory
extension TagViewModelFactoryBase: TagViewModelFactory {
    func viewModel(entity: TagEntity) -> TagViewModel {
        guard let name = entity.name else {
            fatalError("TagEntity has invalid state!")
        }
        return TagViewModel(name: name, url: entity.url)
    }
    
    func viewModel(tag: Tag) -> TagViewModel {
        TagViewModel(name: tag.name, url: tag.url)
    }
}
