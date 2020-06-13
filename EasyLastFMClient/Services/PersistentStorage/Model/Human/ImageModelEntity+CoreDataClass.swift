//
//  ImageModelEntity+CoreDataClass.swift
//  Easy Last FM Client
//
//  Created by Artem Agafonov on 21.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//
//

import Foundation.NSURL
import CoreData

public class ImageModelEntity: NSManagedObject {
    convenience init(context: NSManagedObjectContext,
                     model: ImageModel,
                     relationAssignment: (ImageModelEntity) -> Void) {
        self.init(context: context)
        url = model.url
        imageSize = model.size
        relationAssignment(self)
    }
}

// MARK: - Public
extension ImageModelEntity {
    var imageSize: ImageSize? {
        get {
            guard let size = size else {
                return nil
            }
            return ImageSize(rawValue: size)
        }
        
        set { size = newValue?.rawValue }
    }
}
