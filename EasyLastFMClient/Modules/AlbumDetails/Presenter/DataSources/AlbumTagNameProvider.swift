//
//  AlbumTagNameProvider.swift
//  Easy Last FM Client
//
//  Created by Artem Agafonov on 28.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import Foundation.NSIndexPath

protocol AlbumTagNameProvider {
    func name(at indexPath: IndexPath) -> String
}
