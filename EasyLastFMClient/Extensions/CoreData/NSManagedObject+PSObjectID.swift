//
//  NSManagedObject+PSObjectID.swift
//  Easy Last FM Client
//
//  Created by Artem Agafonov on 25.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import CoreData.NSManagedObject

extension NSManagedObject {
    var id: PSObjectID {
        objectID
    }
}
