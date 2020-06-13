//
//  WikiEntity+CoreDataClass.swift
//  Easy Last FM Client
//
//  Created by Artem Agafonov on 21.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//
//

import Foundation.NSURL
import CoreData

public class WikiEntity: NSManagedObject {
    convenience init(context: NSManagedObjectContext,
                     model: Wiki,
                     relationAssignment: (WikiEntity) -> Void) {
        self.init(context: context)
        published = model.published
        summary = model.summary
        content = model.content
        relationAssignment(self)
    }
}
