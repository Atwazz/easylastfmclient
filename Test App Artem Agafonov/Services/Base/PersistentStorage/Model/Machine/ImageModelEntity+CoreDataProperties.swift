//
//  ImageModelEntity+CoreDataProperties.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 21.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//
//

import Foundation
import CoreData

extension ImageModelEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ImageModelEntity> {
        return NSFetchRequest<ImageModelEntity>(entityName: "ImageModelEntity")
    }

    @NSManaged public var size: String?
    @NSManaged public var url: URL?
    @NSManaged public var album: AlbumEntity?
    @NSManaged public var artist: ArtistEntity?

}
