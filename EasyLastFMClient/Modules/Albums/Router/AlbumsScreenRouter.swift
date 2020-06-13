//
//  AlbumsScreenRouter.swift
//  Easy Last FM Client
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
    
    func showInfo(for album: AlbumModel, artist: Artist) {
        let configuration = AlbumDetailsConfiguration(name: album.name,
                                                      mbid: album.mbid,
                                                      artist: artist,
                                                      id: album.id,
                                                      dismissListener: self)
        let viewController = albumDetailsFactory.viewController(configuration: configuration)
        viewDispatcher.presentModal(viewController,
                                    wrappedInNavigationController: true,
                                    completion: nil)
    }
}

// MARK: - DismissListener
extension AlbumsScreenRouter: DismissListener {
    func dismissable(didDismiss dismissable: Dismissable) {
        
    }
    
    func dismissable(willBeDismissed dismissable: Dismissable) {
        output?.willDismissAlbumInfo()
    }
}
