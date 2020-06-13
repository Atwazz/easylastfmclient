//
//  MainScreenViewOutput.swift
//  Easy Last FM Client
//
//  Created by Artem Agafonov on 14.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import Foundation.NSIndexPath

protocol MainScreenViewOutput {
    func openSearchButtonTapped()
    func viewIsReady()
    func didSelectItem(at indexPath: IndexPath)
}
