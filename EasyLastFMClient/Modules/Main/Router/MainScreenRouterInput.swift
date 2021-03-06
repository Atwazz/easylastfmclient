//
//  MainScreenRouterInput.swift
//  Easy Last FM Client
//
//  Created by Artem Agafonov on 14.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import Foundation.NSError

protocol MainScreenRouterInput {
    func showSearchScreen()
    func showAlertWithError(_ error: LocalizedError, completion: (() -> Void)?)
    func showAlbumDetails(id: PSObjectID)
}
