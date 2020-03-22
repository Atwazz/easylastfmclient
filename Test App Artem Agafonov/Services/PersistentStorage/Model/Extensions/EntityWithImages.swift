//
//  EntityWithImages.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 21.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import Foundation.NSSet
import Foundation.NSURL
import CoreData.NSManagedObjectContext

protocol EntityWithImages {
    var images: NSSet? { get }
    func addToImages(_ values: NSSet)
    func imageUrl(size: ImageSize) -> URL?
}

// MARK: - Default implementation
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
        addImages(images)
    }
    
    func removeAllImages(in context: NSManagedObjectContext) {
        guard let images = images as? Set<ImageModelEntity> else { return }
        images.forEach { context.delete($0) }
    }
    
    func imageUrl(size: ImageSize) -> URL? {
        imagesSet?.filter { $0.imageSize == size }.first?.url
    }
}

// MARK: - Private
private extension EntityWithImages {
    var imagesSet: Set<ImageModelEntity>? {
        images as? Set<ImageModelEntity>
    }
    
    func addImages(_ array: [ImageModelEntity]) {
        addToImages(Set(array) as NSSet)
    }
}
