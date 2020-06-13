//
//  PSViewContextConfiguratorBase.swift
//  Easy Last FM Client
//
//  Created by Artem Agafonov on 19.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import CoreData.NSManagedObjectContext

final class PSViewContextConfiguratorBase {
    // MARK: - Private instance properties
    private let viewContextProvider: PSViewContextProvider
    
    // MARK: - Init
    init(viewContextProvider: PSViewContextProvider) {
        self.viewContextProvider = viewContextProvider
    }
}

// MARK: - ViewContextConfigurator
extension PSViewContextConfiguratorBase: PSViewContextConfigurator {
    func configure() {
        viewContextProvider.viewContext.automaticallyMergesChangesFromParent = true
        viewContextProvider.viewContext.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
    }
}
