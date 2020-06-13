//
//  AlbumEntityFactory.swift
//  Easy Last FM Client
//
//  Created by Artem Agafonov on 21.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import CoreData.NSManagedObjectContext

protocol AlbumEntityFactory {
    func album(model: AlbumExtendedInfo,
               for artist: ArtistEntity,
               in context: NSManagedObjectContext) -> AlbumEntity
}
