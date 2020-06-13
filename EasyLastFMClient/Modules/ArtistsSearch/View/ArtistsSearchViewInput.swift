//
//  ArtistsSearchViewInput.swift
//  Easy Last FM Client
//
//  Created by Artem Agafonov on 14.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import UIKit.UITableView

protocol ArtistsSearchViewInput {
    func setup(with dataSource: UITableViewDataSource)
    func showLoadingIndicator()
    func hideLoadingIndicator()
    func showFooterLoadingIndicator()
    func hideFooterLoadingIndicator()
    func showNoDataPlaceholder()
    func showSearchResults()
    func reloadData()
}
