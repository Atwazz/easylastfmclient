//
//  ArtistsSearchViewOutput.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 14.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import Foundation.NSIndexPath

protocol ArtistsSearchViewOutput {
    func viewIsReady()
    func viewWillAppear()
    func viewDidDisappear()
    
    func triggerSearch(_ searchText: String?)
    func didSelectArtist(at indexPath: IndexPath)
    func willShowArtist(at indexPath: IndexPath)
}
