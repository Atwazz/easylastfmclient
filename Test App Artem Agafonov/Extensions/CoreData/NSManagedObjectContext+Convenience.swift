//
//  NSManagedObjectContext+Convenience.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 29.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import CoreData.NSManagedObjectContext

extension NSManagedObjectContext {
    func albumEntity(with id: PSObjectID) -> AlbumEntity? {
        entity(with: id, of: AlbumEntity.self)
    }
    
    func artistEntity(with id: PSObjectID) -> ArtistEntity? {
        entity(with: id, of: ArtistEntity.self)
    }
}
