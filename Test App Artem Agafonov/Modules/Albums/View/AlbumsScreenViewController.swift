//
//  AlbumsScreenViewController.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 14.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import UIKit

final class AlbumsScreenViewController: UIViewController {
    // MARK: - Public instance properties
    @DelayedImmutable var output: AlbumsScreenViewOutput
    
    // MARK: - Private instance properties
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
        setupTableView()
        output.viewIsReady()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.deselectAllRows()
    }
}

// MARK: - AlbumsScreenViewInput
extension AlbumsScreenViewController: AlbumsScreenViewInput {
    func setup(with dataSource: UITableViewDataSource, title: String) {
        self.title = title
        tableView.dataSource = dataSource
        tableView.reloadData()
    }
    
    func showLoadingIndicator() {
        noDataContainerView.isHidden = true
        loadingIndicatorContainer.isHidden = false
    }
    
    func hideLoadingIndicator() {
        loadingIndicatorContainer.isHidden = true
    }
    
    func showFooterLoadingIndicator() {
        tableView.showFooter()
    }
    
    func hideFooterLoadingIndicator() {
        tableView.hideFooter()
    }
    
    func showNoDataPlaceholder() {
        noDataContainerView.isHidden = false
    }
    
    func hideNoDataPlaceholder() {
        noDataContainerView.isHidden = true
    }
    
    func reloadData() {
        // TODO: - Handle insertions
        tableView.reloadData()
    }
}

// MARK: - UITableViewDelegate
extension AlbumsScreenViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   willDisplay cell: UITableViewCell,
                   forRowAt indexPath: IndexPath) {
        output.willShowAlbum(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        output.didSelectAlbum(at: indexPath)
    }
}

// MARK: - Private
private extension AlbumsScreenViewController {
    func setupTableView() {
        tableView.registerCell(AlbumCell.self)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 66
        tableView.setupFooterLoadingIndicator()
    }
}
