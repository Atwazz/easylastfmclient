//
//  PSBackgroundTaskInvoker.swift
//  Easy Last FM Client
//
//  Created by Artem Agafonov on 20.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import CoreData.NSManagedObjectContext

protocol PSBackgroundTaskInvoker {
    func performBackgroundTask(_ block: @escaping (NSManagedObjectContext) -> Void)
}
