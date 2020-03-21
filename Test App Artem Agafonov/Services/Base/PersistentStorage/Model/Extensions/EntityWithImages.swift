//
//  EntityWithImages.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 21.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import Foundation.NSSet
import CoreData.NSManagedObjectContext

protocol EntityWithImages {
    var images: NSSet? { get }
    func addToImages(_ values: NSSet)
}

extension EntityWithImages {
    func replaceImages(with models: [ImageModel]?,
                       in context: NSManagedObjectContext,
                       relationAssignmentBlock: (ImageModelEntity) -> Void) {
        removeAllImages(in: context)
        guard let models = models else { return }
        let images = models.map { ImageModelEntity(context: context,
                                                   model: $0,
                                                   relationAssignment: relationAssignmentBlock)
        }
        addToImages(Set(images) as NSSet)
    }
    
    func removeAllImages(in context: NSManagedObjectContext) {
        guard let images = images as? Set<ImageModelEntity> else { return }
        images.forEach { context.delete($0) }
    }
}
