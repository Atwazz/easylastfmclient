//
//  PSObjectID+AsObjectID.swift
//  Easy Last FM Client
//
//  Created by Artem Agafonov on 25.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import CoreData.NSManagedObjectID

extension PSObjectID {
    var asObjectId: NSManagedObjectID {
        guard let objectId = self as? NSManagedObjectID else {
            fatalError("API misuse detected")
        }
        return objectId
    }
}
