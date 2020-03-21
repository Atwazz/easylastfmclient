//
//  AlbumsSaver.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 21.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

protocol AlbumsSaver {
    typealias SaverResult = Result<Void, Error>
    
    func save(albums: [AlbumExtendedInfo],
              for artist: Artist,
              completion: @escaping (SaverResult) -> Void)
}
