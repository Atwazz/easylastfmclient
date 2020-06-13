//
//  NSManagedObjectContext+ObjectWithID.swift
//  Easy Last FM Client
//
//  Created by Artem Agafonov on 25.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import CoreData.NSManagedObjectContext

extension NSManagedObjectContext {
    func entity<T: NSManagedObject>(with id: PSObjectID, of type: T.Type) -> T? {
        object(with: id.asObjectId) as? T
    }
}
