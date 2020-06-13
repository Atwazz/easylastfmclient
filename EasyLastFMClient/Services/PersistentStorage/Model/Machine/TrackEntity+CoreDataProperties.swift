//
//  TrackEntity+CoreDataProperties.swift
//  Easy Last FM Client
//
//  Created by Artem Agafonov on 21.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//
//

import Foundation
import CoreData

extension TrackEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TrackEntity> {
        return NSFetchRequest<TrackEntity>(entityName: "TrackEntity")
    }

    @NSManaged public var duration: Int32
    @NSManaged public var name: String?
    @NSManaged public var rank: Int16
    @NSManaged public var url: URL?
    @NSManaged public var album: AlbumEntity?
    @NSManaged public var artist: ArtistEntity?

}
