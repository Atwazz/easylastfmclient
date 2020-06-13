//
//  MainScreenInteractorInput.swift
//  Easy Last FM Client
//
//  Created by Artem Agafonov on 14.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import CoreData.NSFetchedResultsController

protocol MainScreenInteractorInput {
    func obtainResultControllerForAlbums() -> NSFetchedResultsController<AlbumEntity>
}
