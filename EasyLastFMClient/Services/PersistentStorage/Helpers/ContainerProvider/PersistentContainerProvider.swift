//
//  PersistentContainerProvider.swift
//  Easy Last FM Client
//
//  Created by Artem Agafonov on 19.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import CoreData.NSPersistentContainer

protocol PersistentContainerProvider {
    var persistentContainer: NSPersistentContainer { get }
}
