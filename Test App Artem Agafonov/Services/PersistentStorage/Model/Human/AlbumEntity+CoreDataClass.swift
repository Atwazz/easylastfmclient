//
//  AlbumEntity+CoreDataClass.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 21.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//
//

import Foundation
import CoreData

public class AlbumEntity: NSManagedObject { }

// MARK: - EntityWithImages
extension AlbumEntity: EntityWithImages { }

// MARK: - FetchRequests
extension AlbumEntity {
    static func allAlbumsFetchRequest() -> NSFetchRequest<AlbumEntity> {
        let request: NSFetchRequest<AlbumEntity> = AlbumEntity.fetchRequest()
        request.sortDescriptors = [defaultSortDescriptor]
        return request
    }
}

// MARK: - SortDescriptors
private extension AlbumEntity {
    static var defaultSortDescriptor: NSSortDescriptor {
        NSSortDescriptor(key: #keyPath(AlbumEntity.name), ascending: false)
    }
}

// MARK: - Convenience
extension AlbumEntity {
    var tagsArray: [TagEntity]? {
        guard let set = tags?.set(of: TagEntity.self) else {
            return nil
        }
        return Array(set)
    }
    
    var tracksArray: [TrackEntity]? {
        guard let set = tracks?.set(of: TrackEntity.self) else {
            return nil
        }
        return Array(set)
    }
}
