//
//  AlbumsScreenRouter.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 14.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import UIKit.UIAlertController

final class AlbumsScreenRouter {
    // MARK: - Public instance properties
    weak var output: AlbumsScreenRouterOutput?
    
    // MARK: - Private instance properties
    private let viewDispatcher: ViewDispatcher
    private let albumDetailsFactory: AlbumDetailsFactory
    
    // MARK: - Init
    init(viewDispatcher: ViewDispatcher,
         albumDetailsFactory: AlbumDetailsFactory) {
        self.viewDispatcher = viewDispatcher
        self.albumDetailsFactory = albumDetailsFactory
    }
}

// MARK: - AlbumsScreenRouterIMput
extension AlbumsScreenRouter: AlbumsScreenRouterInput {
    func showBasicFailureAlert() {
        func showBasicFailureAlert() {
            let alertController = UIAlertController(title: "Operation failed.",
                                                    message: "Please try again later or contact the developer.",
                                                    preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            viewDispatcher.presentModal(alertController, completion: nil)
        }
    }
    
    func showInfo(for album: Album, artist: Artist) {
        let configuration = AlbumDetailsConfiguration(name: album.name,
                                                      mbid: album.mbid,
                                                      artist: artist,
                                                      id: nil)
        showAlbumDetails(configuration: configuration)
    }
    
    func showInfo(for albumId: PSObjectID) {
        let configuration = AlbumDetailsConfiguration(name: nil,
                                                      mbid: nil,
                                                      artist: nil,
                                                      id: nil)
        showAlbumDetails(configuration: configuration)
    }
}

// MARK: - Private
private extension AlbumsScreenRouter {
    func showAlbumDetails(configuration: AlbumDetailsConfiguration) {
        let viewController = albumDetailsFactory.viewController(configuration: configuration)
        viewDispatcher.presentModal(viewController,
                                    wrappedInNavigationController: true,
                                    completion: nil)
    }
}
