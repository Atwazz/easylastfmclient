//
//  ArtistEntity+CoreDataClass.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 21.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//
//

import Foundation.NSURL
import CoreData

public class ArtistEntity: NSManagedObject { }

// MARK: - EntityWithImages
extension ArtistEntity: EntityWithImages { }

// MARK: - Public
extension ArtistEntity {
    func update(with model: Artist, in context: NSManagedObjectContext) {
        name = model.name
        url = model.url
        mbid = model.mbid
        replaceImages(with: model.images, in: context) { [weak self] in
            $0.artist = self
        }
    }
    
    func album(for model: AlbumExtendedInfo) -> AlbumEntity? {
        album(with: model.name, mbid: model.mbid, url: model.url)
    }
    
    func album(for model: Album) -> AlbumEntity? {
        album(with: model.name, mbid: model.mbid, url: model.url)
    }
}

// MARK: - Private
private extension ArtistEntity {
    func album(with name: String, mbid: String?, url: URL?) -> AlbumEntity? {
        guard let albums = albums?.set(of: AlbumEntity.self) else {
            return nil
        }
        return albums
            .filter { $0.name == name && $0.mbid == mbid && $0.url == url}
            .first
    }
}

// MARK: - FetchRequests
extension ArtistEntity {
    static func fetchRequest(mbid: String?, name: String, url: URL?) -> NSFetchRequest<ArtistEntity> {
        let request: NSFetchRequest<ArtistEntity> = ArtistEntity.fetchRequest()
        request.fetchLimit = 1
        request.predicate = predicate(mbid: mbid, name: name, url: url)
        return request
    }
}

// MARK: - Predicates
private extension ArtistEntity {
    static func predicate(mbid: String?, name: String, url: URL?) -> NSPredicate {
        NSCompoundPredicate(andPredicateWithSubpredicates: [predicate(mbid: mbid),
                                                            predicate(name: name),
                                                            predicate(url: url)])
    }
    
    static func predicate(mbid: String?) -> NSPredicate {
        guard let mbid = mbid else {
            return NSPredicate(format: "\(#keyPath(ArtistEntity.mbid)) = nil")
        }
        return NSPredicate(format: "\(#keyPath(ArtistEntity.mbid)) == %@", mbid)
    }
    
    static func predicate(name: String) -> NSPredicate {
        NSPredicate(format: "\(#keyPath(ArtistEntity.name)) == %@", name)
    }
    
    static func predicate(url: URL?) -> NSPredicate {
        guard let url = url else {
            return NSPredicate(format: "\(#keyPath(ArtistEntity.url)) = nil")
        }
        return NSPredicate(format: "\(#keyPath(ArtistEntity.url)) == %@", url as NSURL)
    }
}
