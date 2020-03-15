//
//  ArtistsSearchViewController.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 14.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import UIKit

final class ArtistsSearchViewController: UIViewController {
    // MARK: - Public instance properties
    @DelayedImmutable var output: ArtistsSearchViewOutput
    
    // MARK: - Private instance properties
    @DelayedImmutable var searchController: UISearchController
    
    // MARK: - Init
    init() {
        super.init(nibName: Self.name, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Artists"
        setupSearchController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        output.viewWillAppear()
        searchController.resignFirstResponder()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        output.viewDidDisappear()
    }
}

// MARK: - Private
private extension ArtistsSearchViewController {
    func setupSearchController() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Artists"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
}

// MARK: - UISearchResultsUpdating
extension ArtistsSearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        output.triggerSearch(searchController.searchBar.text)
    }
}

// MARK: - ArtistsSearchViewInput
extension ArtistsSearchViewController: ArtistsSearchViewInput {
    func cleanSearchResults() {
        
    }
}
