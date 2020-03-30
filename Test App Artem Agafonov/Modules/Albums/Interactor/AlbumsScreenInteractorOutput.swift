//
//  AlbumsScreenInteractorOutput.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 14.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

protocol AlbumsScreenInteractorOutput: class {
    func loadFailed()
    func loadFinished(paginationInfo: PaginationInfo, albums: [Album])
    func fetchedArtistId(_ id: PSObjectID?)
}
