//
//  TagEntity+CoreDataClass.swift
//  Easy Last FM Client
//
//  Created by Artem Agafonov on 21.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//
//

import Foundation.NSURL
import CoreData

public class TagEntity: NSManagedObject {
    convenience init(context: NSManagedObjectContext,
                     model: Tag,
                     relationAssignment: (TagEntity) -> Void) {
        self.init(context: context)
        name = model.name
        url = model.url
        relationAssignment(self)
    }
}
