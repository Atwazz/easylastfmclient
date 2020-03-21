//
//  WikiEntity+CoreDataClass.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 21.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//
//

import Foundation
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
