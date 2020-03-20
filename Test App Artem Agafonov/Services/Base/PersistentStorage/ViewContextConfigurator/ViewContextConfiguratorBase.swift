//
//  ViewContextConfiguratorBase.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 19.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import CoreData.NSManagedObjectContext

final class ViewContextConfiguratorBase {
    // MARK: - Private instance properties
    private let viewContextProvider: ViewContextProvider
    
    // MARK: - Init
    init(viewContextProvider: ViewContextProvider) {
        self.viewContextProvider = viewContextProvider
    }
}

// MARK: - ViewContextConfigurator
extension ViewContextConfiguratorBase: ViewContextConfigurator {
    func configure() {
        viewContextProvider.viewContext.automaticallyMergesChangesFromParent = true
        viewContextProvider.viewContext.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
    }
}
