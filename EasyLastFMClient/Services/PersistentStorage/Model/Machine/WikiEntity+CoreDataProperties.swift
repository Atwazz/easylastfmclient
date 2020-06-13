//
//  WikiEntity+CoreDataProperties.swift
//  Easy Last FM Client
//
//  Created by Artem Agafonov on 21.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//
//

import Foundation
import CoreData

extension WikiEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WikiEntity> {
        return NSFetchRequest<WikiEntity>(entityName: "WikiEntity")
    }

    @NSManaged public var content: String?
    @NSManaged public var published: String?
    @NSManaged public var summary: String?
    @NSManaged public var album: AlbumEntity?

}
