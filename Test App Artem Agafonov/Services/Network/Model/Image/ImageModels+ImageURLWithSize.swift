//
//  ImageModels+ImageURLWithSize.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 28.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import Foundation.NSURL

extension Array where Element == ImageModel {
    func imageUrl(size: ImageSize) -> URL? {
        first(where: { $0.size == size })?.url
    }
}
