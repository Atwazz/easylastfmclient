//
//  PSObjectID+AsObjectID.swift
//  Test App Artem Agafonov
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
