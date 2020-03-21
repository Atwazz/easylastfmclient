//
//  TagEntity+CoreDataClass.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 21.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//
//

import Foundation
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