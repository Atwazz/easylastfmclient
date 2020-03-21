//
//  AlbumEntity+CoreDataProperties.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 21.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//
//

import Foundation
import CoreData

extension AlbumEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AlbumEntity> {
        return NSFetchRequest<AlbumEntity>(entityName: "AlbumEntity")
    }

    @NSManaged public var mbid: String?
    @NSManaged public var name: String?
    @NSManaged public var url: URL?
    @NSManaged public var artist: ArtistEntity?
    @NSManaged public var images: NSSet?
    @NSManaged public var tags: NSSet?
    @NSManaged public var tracks: NSSet?
    @NSManaged public var wiki: WikiEntity?

}

// MARK: Generated accessors for images
extension AlbumEntity {

    @objc(addImagesObject:)
    @NSManaged public func addToImages(_ value: ImageModelEntity)

    @objc(removeImagesObject:)
    @NSManaged public func removeFromImages(_ value: ImageModelEntity)

    @objc(addImages:)
    @NSManaged public func addToImages(_ values: NSSet)

    @objc(removeImages:)
    @NSManaged public func removeFromImages(_ values: NSSet)

}

// MARK: Generated accessors for tags
extension AlbumEntity {

    @objc(addTagsObject:)
    @NSManaged public func addToTags(_ value: TagEntity)

    @objc(removeTagsObject:)
    @NSManaged public func removeFromTags(_ value: TagEntity)

    @objc(addTags:)
    @NSManaged public func addToTags(_ values: NSSet)

    @objc(removeTags:)
    @NSManaged public func removeFromTags(_ values: NSSet)

}

// MARK: Generated accessors for tracks
extension AlbumEntity {

    @objc(addTracksObject:)
    @NSManaged public func addToTracks(_ value: TrackEntity)

    @objc(removeTracksObject:)
    @NSManaged public func removeFromTracks(_ value: TrackEntity)

    @objc(addTracks:)
    @NSManaged public func addToTracks(_ values: NSSet)

    @objc(removeTracks:)
    @NSManaged public func removeFromTracks(_ values: NSSet)

}
