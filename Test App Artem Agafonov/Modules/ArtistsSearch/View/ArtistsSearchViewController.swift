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
    @DelayedImmutable private var searchController: UISearchController
    @IBOutlet private weak var loadingIndicatorContainer: UIView!
    @IBOutlet private weak var noDataContainerView: UIView!
    @IBOutlet private weak var tableView: UITableView!
    
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
        setupTableView()
        output.viewIsReady()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.hidesSearchBarWhenScrolling = false
        tableView.deselectAllRows()
        output.viewWillAppear()
        searchController.resignFirstResponder()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        output.viewDidDisappear()
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
    func reloadData() {
        // TODO: - Handle insertions
        tableView.reloadData()
    }
    
    func showFooterLoadingIndicator() {
        tableView.showFooter()
    }
    
    func hideFooterLoadingIndicator() {
        tableView.hideFooter()
    }
    
    func showLoadingIndicator() {
        noDataContainerView.isHidden = true
        loadingIndicatorContainer.isHidden = false
    }
    
    func hideLoadingIndicator() {
        loadingIndicatorContainer.isHidden = true
    }
    
    func showNoDataPlaceholder() {
        noDataContainerView.isHidden = false
    }
    
    func showSearchResults() {
        noDataContainerView.isHidden = true
        tableView.reloadData()
    }
    
    func setup(with dataSource: UITableViewDataSource) {
        tableView.dataSource = dataSource
        tableView.reloadData()
    }
}

// MARK: - UITableViewDelegate
extension ArtistsSearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   willDisplay cell: UITableViewCell,
                   forRowAt indexPath: IndexPath) {
        output.willShowArtist(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        output.didSelectArtist(at: indexPath)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchController.searchBar.resignFirstResponder()
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
    }
    
    func setupTableView() {
        tableView.registerCell(ArtistCell.self)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 66
        tableView.setupFooterLoadingIndicator()
    }
}
