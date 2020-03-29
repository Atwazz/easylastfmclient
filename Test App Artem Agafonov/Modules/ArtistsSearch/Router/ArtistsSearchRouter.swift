//
//  ArtistsSearchRouter.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 14.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import UIKit.UIAlertController

final class ArtistsSearchRouter {
    // MARK: - Public instance properties
    weak var output: ArtistsSearchRouterOutput?
    
    // MARK: - Private instance properties
    private let viewDispatcher: ViewDispatcher
    private let albumsScreenFactory: AlbumsScreenFactory
    
    // MARK: - Init
    init(viewDispatcher: ViewDispatcher,
         albumsScreenFactory: AlbumsScreenFactory) {
        self.viewDispatcher = viewDispatcher
        self.albumsScreenFactory = albumsScreenFactory
    }
}

// MARK: - ArtistsSearchRouterIMput
extension ArtistsSearchRouter: ArtistsSearchRouterInput {
    func showBasicFailureAlert() {
        let alertController = UIAlertController(title: "Operation failed.",
                                                message: "Please try again later or contact the developer.",
                                                preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        viewDispatcher.presentModal(alertController, completion: nil)
    }
    
    func showAlbums(for artist: Artist) {
        let configuration = AlbumsScreenConfiguration(artist: artist)
        let viewController = albumsScreenFactory.viewController(configuration: configuration)
        viewDispatcher.push(viewController)
    }
}
