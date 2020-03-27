//
//  MainScreenRouter.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 14.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import UIKit.UIAlertController

final class MainScreenRouter {
    // MARK: - Public instance properties
    weak var output: MainScreenRouterOutput?
    
    // MARK: - Private instance properties
    private let viewDispatcher: ViewDispatcher
    private let searchScreenFactory: ScreenFactory
    private let albumDetailsScreenFactory: AlbumDetailsFactory
    
    // MARK: - Init
    init(viewDispatcher: ViewDispatcher,
         searchScreenFactory: ScreenFactory,
         albumDetailsScreenFactory: AlbumDetailsFactory) {
        self.viewDispatcher = viewDispatcher
        self.searchScreenFactory = searchScreenFactory
        self.albumDetailsScreenFactory = albumDetailsScreenFactory
    }
}

// MARK: - MainScreenRouterIMput
extension MainScreenRouter: MainScreenRouterInput {
    func showAlbumDetails(name: String, mbid: String) {
        let configuration = AlbumDetailsConfiguration(name: name,
                                                      mbid: mbid,
                                                      id: nil)
        showAlbumDetails(configuration: configuration)
    }
    
    func showAlbumDetails(id: PSObjectID) {
        let configuration = AlbumDetailsConfiguration(name: nil,
                                                      mbid: nil,
                                                      id: id)
        showAlbumDetails(configuration: configuration)
    }
    
    func showAlertWithError(_ error: LocalizedError, completion: (() -> Void)?) {
        let alertController = UIAlertController(title: "Error",
                                                message: error.localizedDescription,
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        viewDispatcher.presentModal(alertController, completion: completion)
    }
    
    func showSearchScreen() {
        viewDispatcher.push(searchScreenFactory.viewController)
    }
}

// MARK: - Private
private extension MainScreenRouter {
    func showAlbumDetails(configuration: AlbumDetailsConfiguration) {
        let viewController = albumDetailsScreenFactory.viewController(configuration: configuration)
        viewDispatcher.presentModal(viewController)
    }
}
