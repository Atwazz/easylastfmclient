//
//  AlbumDetailsViewOutput.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 14.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import Foundation.NSIndexPath

protocol AlbumDetailsViewOutput {
    func viewIsReady()
    func toggleAlbumIsSaved()
    func closeButtonTapped()
    func selectedTag(at indexPath: IndexPath)
    func selectedTrack(with url: URL?)
    func urlTapped(_ url: URL)
    func artistInfoTapped()
    func albumNameTapped()
    func albumImageTapped()
}
