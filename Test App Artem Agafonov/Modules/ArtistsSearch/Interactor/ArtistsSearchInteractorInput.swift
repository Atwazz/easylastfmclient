//
//  ArtistsSearchInteractorInput.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 14.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

protocol ArtistsSearchInteractorInput {
    func triggerSearch(_ searchText: String, page: UInt?, pageSize: UInt?)
}
