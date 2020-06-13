//
//  AlbumRemover.swift
//  Easy Last FM Client
//
//  Created by Artem Agafonov on 30.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

protocol AlbumRemover {
    func removeAlbum(id: PSObjectID, completion: @escaping () -> Void)
}
