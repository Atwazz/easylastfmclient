//
//  ArtistEntity+CoreDataProperties.swift
//  Easy Last FM Client
//
//  Created by Artem Agafonov on 21.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//
//

import Foundation
import CoreData

extension ArtistEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ArtistEntity> {
        return NSFetchRequest<ArtistEntity>(entityName: "ArtistEntity")
    }

    @NSManaged public var mbid: String?
    @NSManaged public var name: String?
    @NSManaged public var url: URL?
    @NSManaged public var albums: NSSet?
    @NSManaged public var images: NSSet?
    @NSManaged public var tracks: NSSet?

}

// MARK: Generated accessors for albums
extension ArtistEntity {

    @objc(addAlbumsObject:)
    @NSManaged public func addToAlbums(_ value: AlbumEntity)

    @objc(removeAlbumsObject:)
    @NSManaged public func removeFromAlbums(_ value: AlbumEntity)

    @objc(addAlbums:)
    @NSManaged public func addToAlbums(_ values: NSSet)

    @objc(removeAlbums:)
    @NSManaged public func removeFromAlbums(_ values: NSSet)

}

// MARK: Generated accessors for images
extension ArtistEntity {

    @objc(addImagesObject:)
    @NSManaged public func addToImages(_ value: ImageModelEntity)

    @objc(removeImagesObject:)
    @NSManaged public func removeFromImages(_ value: ImageModelEntity)

    @objc(addImages:)
    @NSManaged public func addToImages(_ values: NSSet)

    @objc(removeImages:)
    @NSManaged public func removeFromImages(_ values: NSSet)

}

// MARK: Generated accessors for tracks
extension ArtistEntity {

    @objc(addTracksObject:)
    @NSManaged public func addToTracks(_ value: TrackEntity)

    @objc(removeTracksObject:)
    @NSManaged public func removeFromTracks(_ value: TrackEntity)

    @objc(addTracks:)
    @NSManaged public func addToTracks(_ values: NSSet)

    @objc(removeTracks:)
    @NSManaged public func removeFromTracks(_ values: NSSet)

}
