//
//  AlbumDetailsRouter.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 14.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import Foundation.NSURL
import UIKit.UIAlertController

final class AlbumDetailsRouter {
    // MARK: - Public properties
    @DelayedImmutable var output: AlbumDetailsRouterOutput
    
    // MARK: - Private instance properties
    private let viewDispatcher: ViewDispatcher
    
    // MARK: - Init
    init(viewDispatcher: ViewDispatcher) {
        self.viewDispatcher = viewDispatcher
    }
}

// MARK: - AlbumDetailsRouterIMput
extension AlbumDetailsRouter: AlbumDetailsRouterInput {
    func showOpenConfirmation(url: URL) {
        let alertController = UIAlertController(title: "Do you want to open url?",
                                                message: url.absoluteString,
                                                preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "No", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "Yes", style: .default) { [weak self] _ in
            self?.output.confirmedOpening(url: url)
        }
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        viewDispatcher.presentModal(alertController, completion: nil)
    }
}
