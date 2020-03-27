//
//  AlbumDetailsConfiguration.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 27.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

struct AlbumDetailsConfiguration {
    let name: String?
    let mbid: String?
    let id: PSObjectID?
}

// MARK: - Validatable
extension AlbumDetailsConfiguration: Validatable {
    func isValid() -> Bool {
        name != nil || id != nil
    }
}
