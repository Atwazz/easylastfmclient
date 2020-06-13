//
//  AlbumsScreenViewOutput.swift
//  Easy Last FM Client
//
//  Created by Artem Agafonov on 14.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import Foundation.NSIndexPath

protocol AlbumsScreenViewOutput {
    func viewIsReady()

    func didSelectAlbum(at indexPath: IndexPath)
    func willShowAlbum(at indexPath: IndexPath)
}
