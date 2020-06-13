//
//  AlbumCellModelFactoryBase.swift
//  Easy Last FM Client
//
//  Created by Artem Agafonov on 30.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import CoreData.NSManagedObjectContext

struct AlbumCellModelFactoryBase { }

// MARK: - AlbumCellModelFactory
extension AlbumCellModelFactoryBase: AlbumCellModelFactory {
    func viewModel(for model: AlbumModel) -> AlbumCellModel {
        AlbumCellModel(name: model.name,
                       imageUrl: model.imageUrl,
                       isSaved: model.id != nil)
    }
}
