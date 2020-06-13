//
//  TrackEntity+CoreDataClass.swift
//  Easy Last FM Client
//
//  Created by Artem Agafonov on 21.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//
//

import Foundation.NSURL
import CoreData

public class TrackEntity: NSManagedObject {
    convenience init(context: NSManagedObjectContext,
                     model: Track,
                     relationAssignment: (TrackEntity) -> Void) {
        self.init(context: context)
        name = model.name
        url = model.url
        duration = Int32(model.duration)
        rank = Int16(model.rank)
        relationAssignment(self)
    }
}
