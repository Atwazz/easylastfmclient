//
//  AlbumDetailsRouterInput.swift
//  Easy Last FM Client
//
//  Created by Artem Agafonov on 14.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import Foundation.NSURL

protocol AlbumDetailsRouterInput {
    func showOpenConfirmation(url: URL)
    func showBasicFailureAlert()
    func close()
}
