//
//  AlbumModelFactory.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 30.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

protocol AlbumModelFactory {
    func models(for albums: [Album],
                artistId: PSObjectID?,
                completion: @escaping ([AlbumModel]) -> Void)
}
